class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true, format: {with: /^[a-zA-Z ]*$/, message: "Can only contain letter and white spaces", multiline: true}, length: { minimum: 2 }
  validates :email, uniqueness: true
  validates :contact, uniqueness: true
  validates :statuses_id, inclusion: {in: [1, 2, 3, 4], message: "The Status is not Defined"}


  has_one :status

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
