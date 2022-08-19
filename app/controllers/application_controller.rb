class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :contact, :pay, :qualification, :statuses_id])
	end

	def after_sign_in_path_for(resource)
		vendors_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end
end
