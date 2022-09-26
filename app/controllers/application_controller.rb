class ApplicationController < ActionController::Base
  

  protected

  

  def after_sign_in_path_for(_resource)
     case resource
        when AdminUser then '/admin'
        else '/dashboard'
      end
  end

  def access_denied(exception)
    redirect_to admin_root_path, alert: exception.message
  end

  rescue_from CanCan::AccessDenied do |exception|   
    redirect_to error_path  
  end 

  
end
