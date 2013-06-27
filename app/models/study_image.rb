class StudyImage < ActiveRecord::Base
  attr_accessible :study, :image
  
  belongs_to :study
  belongs_to :image
  
  has_many :selections
  has_many :results, :through => :selections
  
  validates :study, :presence => :true
  validates :image, :presence => :true
  
end