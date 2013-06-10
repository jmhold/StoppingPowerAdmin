require 'spec_helper'

describe Study do
  describe "validation" do
    it "should require a name" do
      Study.new.should_not be_valid
    end
    
    it "should require a name between 1 and 50 characters" do
      Study.new(:name => "").should_not be_valid
      Study.new(:name => "a"*51).should_not be_valid
    end
  end
  
  describe "properties" do
    before(:each) do
      @study = FactoryGirl.create(:study)
    end
    
    it "should have study images" do
      @study.should respond_to(:study_images)
    end
    
    it "should have pairs of images" do
      @study.should respond_to(:pairs)
    end
    
    it "should have a published flag" do
      @study.should respond_to(:published)
    end
  end
  
  describe "pairs" do
    before(:each) do
      @study = FactoryGirl.create(:study)
    end
    
    it "should return pairs sorted by page_number" do
      pair1 = FactoryGirl.create(:pair, :study => @study, :page_number => 2)
      pair2 = FactoryGirl.create(:pair, :study => @study, :page_number => 1)
      pair3 = FactoryGirl.create(:pair, :study => @study, :page_number => 4)
      pair4 = FactoryGirl.create(:pair, :study => @study, :page_number => 3)
      
      @study.pairs.should == [pair2, pair1, pair4, pair3]
    end
  end
end
