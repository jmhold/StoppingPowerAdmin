class StudiesController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def index
    @studies = Study.all
    respond_to do |format|
      format.html
      format.json { render json: @studies }
    end
  end
  
  def show
    @study = Study.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data @study.to_csv }
    end
  end
  
  def new
    @study = Study.new
    @images = Image.where(:deleted => false)
    @pairs_json = pairs_json(@study)
  end
  
  def create
    pairs = params[:study].delete(:pairs)
    @study = Study.create(params[:study])
    update_pairs @study, pairs
    redirect_to :action => 'index'
  end
  
  def edit
    @study = Study.find(params[:id])
    @images = Image.where(:deleted => false)
    @pairs_json = pairs_json(@study)
    if(@study.published)
      flash[:error] = "You cannot edit a survey that has already been published."
      render 'show'
    end
  end
  
  def update
    @study = Study.find(params[:id])
    pairs = params[:study].delete(:pairs)
    if(@study.update_attributes(params[:study]))
      update_pairs @study, pairs
      render 'show'
    else
      render 'edit'
    end
  end
  
  def destroy
    Study.find(params[:id]).delete
    redirect_to :action => 'index'
  end
  
  def publish
    @study = Study.find(params[:id])
    @study.published = true
    @study.save
    redirect_to :action => 'index'
  end
  
  def activate
    @study = Study.find(params[:id])
    @study.active = params[:active]
    @study.save
    redirect_to :action => 'index'
  end
  
  def update_pairs study, pairs_json
    if(pairs_json)
      study.pairs.delete_all
      pairs = JSON.parse(pairs_json)
      pairs.each_with_index do |images, page|
        pair = study.pairs.build
        pair.choice1 = study.study_images.create(:image => Image.find(images[0]))
        pair.choice2 = study.study_images.create(:image => Image.find(images[1]))
        pair.page_number = page
        pair.save!
      end
      study.save
    end
  end
  
  def pairs_json study
    pairs = []
    study.pairs.each do |pair|
      pairs << [pair.choice1.image.id, pair.choice2.image.id]
    end
    pairs.to_json
  end
end