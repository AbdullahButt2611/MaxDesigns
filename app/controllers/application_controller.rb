class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name contact pay qualification activity_status avatar user_roles])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username name contact pay qualification activity_status avatar user_roles])
  end

  def after_sign_in_path_for(_resource)
     case resource
        when AdminUser then '/admin'
        else '/dashboard'
      end
  end

  
end
