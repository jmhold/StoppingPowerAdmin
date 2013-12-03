class FoldersController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def create
    folder = Folder.new(params[:folder])
    if folder.save
      flash[:notice] = "Successfully created folder: #{folder.name}"
    else
      flash[:error] = "Unable to create folder. Invalid name."
    end
    redirect_to images_path
  end
  
  def destroy
    folder = Folder.find(params[:id])
    if folder.images.where(:deleted => false).empty?
      folder.delete
      flash[:notice] = "Successfully deleted folder: #{folder.name}"
      redirect_to images_path
    else
      flash[:error] = "Unable to delete folder. Folder must be empty."
      redirect_to images_path(:folder => folder.id)
    end
  end
end