class WelcomesController < ApplicationController
  
  def index; end

  def about; end

  def profile; 
    authorize! :profile, current_user
  end

  def error
    
  end
  
end
