require 'spec_helper'

describe Pair do
  describe "validation" do
    before(:each) do
      @study = FactoryGirl.create(:study)      
      @study_image1 = FactoryGirl.create(:study_image, :study => @study)
      @study_image2 = FactoryGirl.create(:study_image, :study => @study)
      @attr = { :study => @study, :study_image1 => @study_image1, :study_image2 => @study_image2, :page_number => 1 }
    end
    
    it "should create with valid attributes" do
      Pair.create!(@attr)
    end
    
    it "should require a study and two study images" do
      Pair.new(@attr.merge(:study => nil)).should_not be_valid
      Pair.new(@attr.merge(:study_image1 => nil)).should_not be_valid
      Pair.new(@attr.merge(:study_image2 => nil)).should_not be_valid
    end
    
    it "should require a page number" do
      Pair.new(@attr.merge(:page_number => nil)).should_not be_valid
    end
  end
end
