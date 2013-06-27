class Selection < ActiveRecord::Base
  attr_accessible :result_id, :study_image_id
  
  belongs_to :result
  belongs_to :study_image
end
