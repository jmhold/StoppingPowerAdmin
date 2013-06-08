class Pair < ActiveRecord::Base
  # :page_number
  attr_accessible :study, :choice1, :choice2, :page_number
  
  belongs_to :study
  belongs_to :choice1, :class_name => "StudyImage", :foreign_key => "study_image1_id"
  belongs_to :choice2, :class_name => "StudyImage", :foreign_key => "study_image2_id"
  
  validates :study, :presence => true
  validates :choice1, :presence => true
  validates :choice2, :presence => true
  validates :page_number, :presence => true
end
