class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name contact pay qualification status avatar])
  end

  def after_sign_in_path_for(_resource)
    vendors_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end
end
