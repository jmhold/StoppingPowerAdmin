class ImagesController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def new
    @image = Image.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end
  
  def create
    @image = Image.new
    @image.info = params[:image][:info]
    if @image.save
      respond_to do |format|
        format.html { render 'show' }
        format.json
      end
    else
      render :json => { "errors" => @image.errors } 
    end
  end
  
  def edit
    @image = Image.find(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    if(@image.update_attributes(params[:image]))
      flash.now[:success] = "Image updated successfully!"
    else
      flash.now[:error] = "Unable to update image."
    end
    render 'edit'
  end
  
  def show
    @image = Image.find(params[:id])
    render 'edit'
  end
  
  def index
    @images = Image.all
  end
end