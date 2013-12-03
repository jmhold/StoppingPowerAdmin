class ImagesController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def new
    @image = Image.new
    @folder = current_folder
    @folders = Folder.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end
  
  def create
    @image = Image.new
    @folder = current_folder
    @folders = Folder.all
    @image.info = params[:image][:info]
    @image.folder_id = params[:folder_id]
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
    @folder = current_folder
    @folders = Folder.all
    @images = @folder.images.where(:deleted => false)
  end
  
  def modify
    action = params[:commit].downcase
    image_ids = params[:image_ids]
    src_folder = params[:folder_src] ? params[:folder_src] : Folder.first.id
    if(image_ids) 
      if(action == 'delete')
          image_ids.each do |id|
            image = Image.find(id)
            image.deleted = true
            image.save!
          end
      elsif action == 'move' && params[:folder_dest]
        image_ids.each do |id|
          image = Image.find(id)
          image.folder_id = params[:folder_dest]
          image.save!
        end
      end
    end
    redirect_to images_path(:folder => src_folder)
  end
end