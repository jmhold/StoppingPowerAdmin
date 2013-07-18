class Study < ActiveRecord::Base
  # caption
  attr_accessible :name, :caption
  
  validates :name, :presence => true, :length => {:within => 1..50}
  
  has_many :study_images
  has_many :pairs, :order => 'page_number ASC'

  def as_json(options={})
    super(options).merge({"pairs" => self.pairs.as_json })
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Study: #{self.name}", "", ""]
      csv << ["Image Name","Image Type", "Image URL", "Number of Selections"]
      study_images.each do |study_image|
        csv << [study_image.image.name, study_image.image.image_type, study_image.image.info.url, study_image.selections.count]
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