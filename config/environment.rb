# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {

  # This is the string literal 'apikey', NOT the ID of your API key
  user_name: 'apikey', 

  # This is the secret sendgrid API key which was issued during API key creation
  password: Rails.application.credentials.dig(:sendgrid, :api_key), 

  domain: 'max-designs.herokuapp.com',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}