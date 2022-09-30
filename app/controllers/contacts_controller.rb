class ContactsController < ApplicationController
  

  def index
    authorize! :index, current_user
    @contacts = Contact.all_contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save

      @user = User.last
      redirect_to root_path

    else
      render layout: false
    end
  end


 




  
# ===============================================================================================================================
# ==================================      Additional Functions Defined      =====================================================
# ===============================================================================================================================
  private

  # Method to allow the strong params
  def contact_params
    params.require(:contact).permit(:name, :email, :contactNumber, :company, :message)
  end


end
