class Study < ActiveRecord::Base
  # caption
  attr_accessible :name, :caption, :instructions, :timer, :randomize, :warmup_pairs
  
  validates :name, :presence => true, :length => {:within => 1..50}
  validates_numericality_of :timer
  validates :instructions, :presence => true
  
  has_many :study_images, :dependent => :destroy
  has_many :pairs, :order => 'page_number ASC', :dependent => :destroy
  has_many :results

  def as_json(options={})
    super(options).merge({"pairs" => self.pairs.as_json })
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      images = {}
      opportunities = {}
      result_count = self.results.size
      
      csv << ["Study: #{self.name}", "", ""]
      csv << ["Total Results:", result_count, ""]
      csv << [""]
      
      csv << ["", "Image Type","Image Name", "Number of Wins"]
      pairs.each_with_index do |pair|
        image1 = pair.choice1.image
        image2 = pair.choice2.image
        count1 = pair.choice1.selections.count
        count2 = pair.choice2.selections.count
        page = pair.page_number+1
        
        if(pair.page_number < self.warmup_pairs)
          csv << ["Warm Up #{page}", image1.image_type, image1.name, count1]
          csv << ["", image2.image_type, image2.name, count2]
          csv << [""]
        else
          csv << ["Face Off #{page-self.warmup_pairs}", image1.image_type, image1.name, count1]
          csv << ["", image2.image_type, image2.name, count2]
          csv << [""]
        
          accumulate count1, images, image1
          accumulate count2, images, image2
          accumulate 1, opportunities, image1
          accumulate 1, opportunities, image2
        end
      end
      
      csv << [""]
      csv << [""]
      csv << ["Image Type","Image Name", "Overall Clicks", "Opportunities", "Win %"]
      images.each do |image, count|
        opps = opportunities[image]*result_count
        csv << [image.image_type, image.name, count, opps, (count.to_f/opps.to_f)*100.0]
      end
    end
  end
  
  def copy
    study = Study.create(:name => copy_name)
    study.caption = self.caption
    pairs.each do |pair|
      pair_copy = study.pairs.build
      pair_copy.choice1 = study.study_images.create(:image => pair.choice1.image)
      pair_copy.choice2 = study.study_images.create(:image => pair.choice2.image)
      pair_copy.page_number = pair.page_number
      pair.save!
    end
    study.save!
    study
  end
  
  private
    def copy_name
      base_name = self.name + " copy"
      num = 1
      name = base_name
      while(Study.find_by_name(name)) do
        num += 1
        name = base_name + " #{num}"
      end
      name
    end
    
    def accumulate count, hash, key
      count += hash[key] if hash[key]
      hash[key] = count
    end
end