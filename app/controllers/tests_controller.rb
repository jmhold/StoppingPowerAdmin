class TestsController < ApplicationController
  before_filter :authenticate_user!, :is_admin
  
  def index
  end
  
end