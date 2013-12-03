class Folder < ActiveRecord::Base
  attr_accessible :name
  
  has_many :images
  validates :name, :presence => true, :length => {:within => 1..50}
end