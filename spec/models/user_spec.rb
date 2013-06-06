require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "admin" do
    it "should properly identify as an admin" do
      @user.should_not be_admin
      
      @user.admin = true
      @user.save!
      @user.should be_admin
    end
   end 
end