require 'spec_helper'

describe AppController do
  describe "result" do
    it "should create a result when given correct JSON" do
      @study = FactoryGirl.create(:study)
      pair1 = FactoryGirl.create(:pair, :study => @study, :page_number => 1)
      pair2 = FactoryGirl.create(:pair, :study => @study, :page_number => 2)
      
      expected = { :first_name => "first", :last_name => "last", :group_id => "id", :study_id => @study.id, :gender => "male", 
        :selections => [pair1.choice1.id, pair2.choice2.id] }
      
      post 'result', :format => :json, :result => expected
      
      result = Result.find_by_first_name("first")
      
      result.first_name.should == "first"
      result.last_name.should == "last"
      result.group_id.should == "id"
      result.gender.should == "male"
      result.study.should == @study
      result.study_images[0].should == pair1.choice1
      result.study_images[1].should == pair2.choice2
    end
  end
end