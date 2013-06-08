require 'spec_helper'

describe StudyImage do
  before(:each) do
    @study = FactoryGirl.create(:study)
    @image = FactoryGirl.create(:image)
  end
  
  describe "validation" do
    it "should create a new instance with valid attributes" do
      StudyImage.new(:study => @study, :image => @image).should be_valid
    end
    
    it "should require a study and image" do
      StudyImage.new.should_not be_valid
      StudyImage.new(:study => @study).should_not be_valid
      StudyImage.new(:image => @image).should_not be_valid
    end
  end
  
  describe "attributes" do
    it "should have a click_count" do
      FactoryGirl.create(:study_image, :study => @study).should respond_to(:click_count)
    end
  end
end
