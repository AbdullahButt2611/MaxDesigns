class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true,
                   format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces', multiline: true }, length: { minimum: 2 }
  
  validates :contact, uniqueness: true

  enum activity_status: {
    no_role: 0,
    available: 1,
    unavailable: 2,
    on_leave: 3
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
