class StudyImage < ActiveRecord::Base
  # :click_count
  attr_accessible :study, :image
  
  belongs_to :study
  belongs_to :image
  
  validates :study, :presence => :true
  validates :image, :presence => :true
  
end
