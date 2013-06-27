class Result < ActiveRecord::Base
  attr_accessible :first_name, :gender, :group_id, :last_name, :study_id
  
  belongs_to :study
  has_many :selections
  has_many :study_images, :through => :selections

end