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
  
  describe "copying" do
    before(:each) do
      @study1 =  FactoryGirl.create(:study, :name => "Study A")
      @pair1 = FactoryGirl.create(:pair, :study => @study1, :page_number => 1)
      @pair2 = FactoryGirl.create(:pair, :study => @study1, :page_number => 2)
    end
    
    it "should name the study correctly" do
      study2 = @study1.copy
      study3 = @study1.copy
      study4 = @study1.copy
      study5 = study3.copy
      
      study2.name.should == "Study A copy"
      study3.name.should == "Study A copy 2"
      study4.name.should == "Study A copy 3"
      study5.name.should == "Study A copy 2 copy"
    end
    
    it "should produce a study with identical image pairs" do
      study2 = @study1.copy
      study2.pairs[0].choice1.image.should == @pair1.choice1.image
      study2.pairs[0].choice2.image.should == @pair1.choice2.image
      study2.pairs[1].choice1.image.should == @pair2.choice1.image
      study2.pairs[1].choice2.image.should == @pair2.choice2.image
    end
    
    it "should not copy selections" do
      result = Result.create
      result.selections.create(:study_image_id => @pair1.choice1.id)
      
      study2 = @study1.copy
      study2.pairs[0].choice1.selections.size.should == 0
    end
  end
end
