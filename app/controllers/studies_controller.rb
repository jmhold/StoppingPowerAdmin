class StudiesController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def index
    @studies = Study.all
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end