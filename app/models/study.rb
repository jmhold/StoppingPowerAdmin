class Study < ActiveRecord::Base
  # caption
  attr_accessible :name, :caption, :instructions, :timer
  
  validates :name, :presence => true, :length => {:within => 1..50}
  validates_numericality_of :timer
  validates :instructions, :presence => true
  
  has_many :study_images, :dependent => :destroy
  has_many :pairs, :order => 'page_number ASC', :dependent => :destroy

  def as_json(options={})
    super(options).merge({"pairs" => self.pairs.as_json })
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      images = {}
      
      csv << ["Study: #{self.name}", "", ""]
      csv << [""]
      
      csv << ["", "Image Type","Image Name", "Number of Wins"]
      pairs.each do |pair|
        image1 = pair.choice1.image
        image2 = pair.choice2.image
        count1 = pair.choice1.selections.count
        count2 = pair.choice2.selections.count
        
        csv << ["Face Off #{pair.page_number+1}", image1.image_type, image1.name, count1]
        csv << ["", image2.image_type, image2.name, count2]
        csv << [""]
        
        count1 += images[image1] if images[image1]
        count2 += images[image2] if images[image2]
        
        images[image1] = count1
        images[image2] = count2
      end
      
      csv << [""]
      csv << [""]
      csv << ["Image Type","Image Name", "Overall Clicks"]
      images.each do |image, count|
        csv << [image.image_type, image.name, count]
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
end