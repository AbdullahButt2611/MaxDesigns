class SendSignUpEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    byebug
    UserMailer.with(user: user).welcome_email.deliver_later
  end
end
