class User < ApplicationRecord

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true,
                   format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces', multiline: true }, length: { minimum: 2 }
  
  validates :contact, uniqueness: true

  scope :all_user, -> {where(activity_status: 0)}

  enum activity_status: {
    no_role: 0,
    available: 1,
    unavailable: 2,
    on_leave: 3,
    simple_user: 4
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
