class UserMailer < ApplicationMailer

	default from: 'abutt2210@gmail.com'

	def welcome_email
		@user = params[:user]
		@url = 'hhtp://example.com/login'

		mail(to: @user.email, subject: "Welcome to Max Designs")
	end  

end
