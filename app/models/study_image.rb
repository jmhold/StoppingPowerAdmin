class StudyImage < ActiveRecord::Base
  attr_accessible :study, :image
  
  belongs_to :study
  belongs_to :image
  
  has_many :selections, :dependent => :destroy
  has_many :results, :through => :selections, :dependent => :destroy
  
  validates :study, :presence => :true
  validates :image, :presence => :true
  
end