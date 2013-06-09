require 'spec_helper'

describe ImagesController do
  before(:each) do
    @image = FactoryGirl.create(:image)
  end
  
  describe "when admin" do
    before(:each) do
      @user = FactoryGirl.create(:user, :admin => true)
      sign_in @user
    end
    
    describe "create" do
      it "should create an image" do
        lambda do
          post :create, :image => { :info => "hello.jpg" }
        end.should change(Image, :count).by(1)
      end
    end # create
  end
  
  describe "authentication" do
    it "should be required for all" do
      get :new
      response.should redirect_to(user_session_path)

      post :create
      response.should redirect_to(user_session_path)

      get :show, :id => @image
      response.should redirect_to(user_session_path)
    end
    
    describe "when signed in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      
      it "should require admin privileges for all" do
        lambda do
          get :new
        end.should raise_error(ActionController::RoutingError)

        lambda do
          post :create
        end.should raise_error(ActionController::RoutingError)
      
        lambda do
          get :edit
        end.should raise_error(ActionController::RoutingError)
      
        lambda do
          put :update
        end.should raise_error(ActionController::RoutingError)
      
        lambda do
          delete :destroy
        end.should raise_error(ActionController::RoutingError)
      
        lambda do
          get :index
        end.should raise_error(ActionController::RoutingError)
      end
    end
  end # authentication
  
end
