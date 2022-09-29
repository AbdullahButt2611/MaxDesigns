class ApplicationController < ActionController::Base
  

  protected


  #   This Method will check the user type after logging into the system and then will 
  #   redirect it to a particular postion depending on the requirement
  def after_sign_in_path_for(_resource)

    case resource

      when AdminUser then '/admin'
      else '/dashboard'

    end

  end



  #  Method to define the root that if a user is not allowed to acces the page then an 
  # exception is raised. To deal with it, the user is redirected to a page using the path 
  # defined in this method
  
  def access_denied(exception)
    redirect_to admin_root_path, alert: exception.message
  end



  rescue_from CanCan::AccessDenied do |exception|   
    redirect_to error_path  
  end 

  
end
