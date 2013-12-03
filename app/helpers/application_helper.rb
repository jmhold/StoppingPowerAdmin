module ApplicationHelper
  
  def current_folder
    Folder.find(params[:folder] ? params[:folder] : Folder.first.id)
  end
  
  private
    def is_admin
      raise ActionController::RoutingError.new(404) unless current_user.is_admin?
    end
end
