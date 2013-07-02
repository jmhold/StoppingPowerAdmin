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
end