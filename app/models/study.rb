class Study < ActiveRecord::Base
  # caption
  attr_accessible :name, :caption
  
  validates :name, :presence => true, :length => {:within => 1..50}
  
  has_many :study_images
  has_many :pairs, :order => 'page_number ASC'

  def as_json(options={})
    super(options).merge({"pairs" => self.pairs.as_json })
  end
end