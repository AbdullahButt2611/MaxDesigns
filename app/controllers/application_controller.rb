class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  

  protected

  

  def after_sign_in_path_for(_resource)
     case resource
        when AdminUser then '/admin'
        else '/dashboard'
      end
  end

  
end
