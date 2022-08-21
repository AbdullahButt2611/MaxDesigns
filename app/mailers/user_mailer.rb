class UserMailer < ApplicationMailer

	default from: 'support@maxdesigns.com'

	def welcome_email
		@user = params[:user]
		@url = 'hhtp://example.com/login'

		mail(to: @user.email, subject: "Welcome to My awesome Site")
	end  

end
