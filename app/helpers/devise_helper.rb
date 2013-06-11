module DeviseHelper
  def devise_error_messages!
    # eliminate copies
    h = resource.errors.full_messages.inject({}) {|h,e| h[e] = ''; h }
    h.keys
  end

  def devise_error_messages?
    begin
      !resource.errors.empty?
    rescue
      false
    end
  end

  def devise_flash_error
    return unless devise_error_messages?
    errors = devise_error_messages!
    flash.now['error'] = errors.first
  end
end