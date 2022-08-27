class User < ApplicationRecord

  # Associations
  mount_uploader :avatar, AvatarUploader
  has_one :vendor, required: false


  # Validations
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true,
                   format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces', multiline: true }, length: { minimum: 2 }
  validates :contact, uniqueness: true
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar



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


  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

end
