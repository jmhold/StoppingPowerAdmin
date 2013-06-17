class AppController < ApplicationController
  def index
    studies = Study.all
    respond_to do |format|
      format.json { render json: studies }
    end
  end
end