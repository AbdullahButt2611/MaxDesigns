class User < ApplicationRecord

  # Associations
  
  has_one :vendor, required: false 



  # Validations
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true,
                   format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces', multiline: true }, length: { minimum: 2 }
  
  validates :contact, uniqueness: true



  # Scopes
  scope :all_user, -> {where(activity_status: 0)}



  # Enum declarations
  enum activity_status: {
    no_role: 0,
    available: 1,
    unavailable: 2,
    on_leave: 3,
    simple_user: 4
  }

  enum user_roles: {
    customer:      0,
    developer:     1,
    architect:     2,
    hr:            3,
    management:    4,
    accountant:    5,
    admin:         6,
    vendor:        7

  }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
