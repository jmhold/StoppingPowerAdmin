class Pair < ActiveRecord::Base
  # :page_number
  attr_accessible :study, :study_image1, :study_image2, :page_number
  
  belongs_to :study
  belongs_to :study_image1, :class_name => "StudyImage", :foreign_key => "study_image1_id"
  belongs_to :study_image2, :class_name => "StudyImage", :foreign_key => "study_image2_id"
  
  validates :study, :presence => true
  validates :study_image1, :presence => true
  validates :study_image2, :presence => true
  validates :page_number, :presence => true
end
