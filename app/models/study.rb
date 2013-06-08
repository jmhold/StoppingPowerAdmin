class Study < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, :presence => true, :length => {:within => 1..50}
  
  has_many :study_images
  has_many :pairs, :order => 'page_number ASC'
  
end
