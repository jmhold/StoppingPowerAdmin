require 'spec_helper'

describe StudiesController do
  render_views
  
  before(:each) do
    @study = FactoryGirl.create(:study)
  end
  
  describe "authentication" do
    it "should be required for new, create, edit, update, destroy, and index" do
      get :new
      response.should redirect_to(user_session_path)

      post :create
      response.should redirect_to(user_session_path)

      get :edit, :id => @study
      response.should redirect_to(user_session_path)

      put :update, :id => @study
      response.should redirect_to(user_session_path)

      delete :destroy, :id => @study
      response.should redirect_to(user_session_path)

      get :index
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
  
  describe "when authenticated" do
    before(:each) do
      @user = FactoryGirl.create(:user, :admin => true)
      sign_in @user
      
      @study1 = FactoryGirl.create(:study, :name => "A")
      @study2 = FactoryGirl.create(:study, :name => "B")
    end
    
    describe "index" do
      it "should list available studies" do
        get :index
        response.body.should have_link("A", :href => study_path(@study1))
        response.body.should have_link("B", :href => study_path(@study2))
      end
    end
  end
end