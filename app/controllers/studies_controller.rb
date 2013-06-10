class StudiesController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def index
    @studies = Study.all
  end
  
  def new
    @study = Study.new
  end
  
  def create
    pairs = params[:study].delete(:pairs)
    @study = Study.create(params[:study])
    update_pairs @study, pairs
    render 'show'
  end
  
  def edit
    @study = Study.find(params[:id])
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
  end
  
  def update_pairs study, pairs_json
    if(pairs_json)
      pairs = JSON.parse(pairs_json)
      pairs.each_with_index do |images, page|
        pair = study.pairs.build
        pair.choice1 = study.study_images.create(:image => Image.find(images[0]))
        pair.choice2 = study.study_images.create(:image => Image.find(images[1]))
        pair.page_number = page
        pair.save!
      end
      study.save
    else
      study.pairs.delete_all
    end
  end
end