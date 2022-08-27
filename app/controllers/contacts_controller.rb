class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      @user = User.last
      
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :contactNumber, :company, :message)
  end
end
