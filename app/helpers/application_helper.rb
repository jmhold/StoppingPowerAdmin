module ApplicationHelper
  private
    def is_admin
      raise ActionController::RoutingError.new(404) unless current_user.is_admin?
    end
end
