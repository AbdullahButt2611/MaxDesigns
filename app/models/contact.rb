class Contact < ApplicationRecord
  
  #==========================         Validations    =======================================
  validates :name, presence: true
  validates :email, presence: true
  validates :contactNumber, presence: true
  validates :message, presence: true, length: { minimum: 10 }




  #==========================         Scopes    =======================================
  scope :all_contacts, -> {Contact.all.order("created_at DESC")}


  
end
