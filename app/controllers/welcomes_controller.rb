class WelcomesController < ApplicationController
  skip_before_action :authenticate_user!
  def index; end

  def about; end

  def profile; end
  
end
