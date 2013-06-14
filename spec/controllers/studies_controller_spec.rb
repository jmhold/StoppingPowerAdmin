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
      
      describe "json" do
        it "should return a json list of survey names" do
          get :index, :format => :json
          studies = JSON.parse(response.body)
          studies[0]['name'].should == @study.name
          studies[1]['name'].should == @study1.name
          studies[2]['name'].should == @study2.name
        end
        
        it "should return if the surveys are published" do
          @study1.published = true
          @study1.save!
          get :index, :format => :json
          studies = JSON.parse(response.body)
          studies[0]['published'].should == false
          studies[1]['published'].should == true
        end
        
        it "should return a list of image pairs with the survey" do
          pair1 = FactoryGirl.create(:pair, :study => @study, :page_number => 1)
          pair2 = FactoryGirl.create(:pair, :study => @study, :page_number => 2)
          
          get :index, :format => :json
          studies = JSON.parse(response.body)
          studies[0]['pairs'][0][0].should == pair1.choice1.image.info.url
          studies[0]['pairs'][0][1].should == pair1.choice2.image.info.url
          studies[0]['pairs'][1][0].should == pair2.choice1.image.info.url
          studies[0]['pairs'][1][1].should == pair2.choice2.image.info.url
        end
      end
    end
    
    describe "create" do
      it "should create a survey" do
        lambda do
          post :create, :study => { :name => "WHAT"}
        end.should change(Study, :count).by(1)
      end
      
      it "should properly parse image ids into pairs" do
        image1 = FactoryGirl.create(:image)
        image2 = FactoryGirl.create(:image)
        image3 = FactoryGirl.create(:image)
        image4 = FactoryGirl.create(:image)
        
        pairs = [[image3.id, image2.id],[image4.id,image1.id]].to_json
        
        post :create, :study => {:name => "AAA", :pairs => pairs }
        
        study = Study.find_by_name("AAA")
        
        study.pairs[0].choice1.image.should == image3
        study.pairs[0].choice2.image.should == image2
        study.pairs[1].choice1.image.should == image4
        study.pairs[1].choice2.image.should == image1
      end
    end #create
    
    describe "edit" do
      it "should show an error if study is published" do
        @study.published = true
        @study.save!
        get :edit, :id => @study
        flash[:error].should =~ /been published/i
      end
      
      it "should render 'show' if study is published" do
        @study.published = true
        @study.save!
        get :edit, :id => @study
        response.should render_template 'show'
      end
      
      it "should be successful if study is not published" do
        get :edit, :id => @study
        flash[:error].should be_nil
        response.should be_successful
      end
    end # edit
    
    describe "update" do
      it "should update the survey" do
        @study.name = "Hello!"
        @study.save!
        put :update, :id => @study, :study => { :name => "new name" }
        Study.find(@study.id).name.should eq("new name")
      end
      
      it "should properly parse image ids into pairs" do
        image1 = FactoryGirl.create(:image)
        image2 = FactoryGirl.create(:image)
        image3 = FactoryGirl.create(:image)
        image4 = FactoryGirl.create(:image)
        
        pairs = [[image3.id, image2.id],[image4.id,image1.id]].to_json
        
        put :update, :id => @study, :study => {:name => "AAA", :pairs => pairs }
        
        study = Study.find_by_name("AAA")
        
        study.pairs[0].choice1.image.should == image3
        study.pairs[0].choice2.image.should == image2
        study.pairs[1].choice1.image.should == image4
        study.pairs[1].choice2.image.should == image1
      end
    end # update
    
    describe "publish" do
      it "should publish the survey" do
        put :publish, :id => @study
        Study.find(@study.id).should be_published
      end
    end
  end
end