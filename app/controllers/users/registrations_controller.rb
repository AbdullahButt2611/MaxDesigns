# # frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
#   before_action :configure_sign_up_params, only: [:create]
#   before_action :configure_account_update_params, only: [:update]
		# before_action :delete_avatar_resource, only: [:update]
		before_action :configure_permitted_parameters, only: [:create, :update]

	before_action :all_registered_users

#   # GET /resource/sign_up
#   def new
#     super
#   end

  # POST /resource
def create
	  super
	  if(@user.persisted?)
	  	UserMailer.with(user: @user).welcome_email.deliver_now
	  end
end

def registered_users
end

def simple_user_update
	@user = User.find(params[:format])
	@user.simple_user!
	render "registered_users"
end

def update_activity_status
	@user = User.find(params[:format])
	@user.available!
	render "registered_users"
end


private
  def edit_params
    params.require(:user).permit(:activity_status)
  end

  def all_registered_users
  	@all_users = User.all_user
  end

  def delete_avatar_resource
  	# current_user.avatar.purge
  	# current_user.avatar = params[:user][:avatar]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name contact pay qualification avatar  avatar_cache activity_status file user_roles])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username name contact pay qualification avatar  avatar_cache remove_avatar activity_status file user_roles])
  end

#   # GET /resource/edit
#   def edit
#     super
#   end

#   # PUT /resource
#   def update
#     super
#   end

#   # DELETE /resource
#   def destroy
#     super
#   end

#   # GET /resource/cancel
#   # Forces the session data which is usually expired after sign
#   # in to be expired now. This is useful if the user wants to
#   # cancel oauth signing in/up in the middle of the process,
#   # removing all OAuth session data.
#   def cancel
#     super
#   end

#   protected

#   # If you have extra params to permit, append them to the sanitizer.
#   def configure_sign_up_params
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
#   end

#   # If you have extra params to permit, append them to the sanitizer.
#   def configure_account_update_params
#     devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
#   end

#   # The path used after sign up.
#   def after_sign_up_path_for(resource)
#     super(resource)
#   end

#   # The path used after sign up for inactive accounts.
#   def after_inactive_sign_up_path_for(resource)
#     super(resource)
#   end
end
