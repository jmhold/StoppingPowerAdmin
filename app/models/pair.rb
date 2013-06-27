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
  
  def as_json(options={})
    super(options.merge(:only => [:page_number, :id])).merge(
                {"choice1" => self.choice1.image.info.url, "choice1_id" => self.choice1.id, "choice1_caption" => self.choice1.image.caption,
                 "choice2" => self.choice2.image.info.url, "choice2_id" => self.choice2.id, "choice2_caption" => self.choice2.image.caption })
  end
end