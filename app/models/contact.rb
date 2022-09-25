class Contact < ApplicationRecord
  # validates :name, presence: true, format: {with: [a-zA-z\s], message: "Only alphabets and white spaces are allowed"}
  validates :name, presence: true
  validates :email, presence: true
  validates :contactNumber, presence: true
  validates :message, presence: true, length: { minimum: 10 }


  scope :all_contacts, -> {Contact.all.order("created_at DESC")}
end
