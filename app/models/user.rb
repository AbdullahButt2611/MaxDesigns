class User < ApplicationRecord

  # Associations
  mount_uploader :avatar, AvatarUploader
  has_one :vendor, required: false, dependent: :destroy
  has_many :project_details


  # Validations
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true,
                   format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces', multiline: true }, length: { minimum: 2 }
  validates :contact, uniqueness: true
    # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validates :pay, presence: true, numericality: {greater_than_or_equal_to: 0 , less_than_or_equal_to: 1000000}



  # Scopes
  scope :all_user, -> {where(activity_status: 0)}
  scope :all_active_users, ->{where.not(activity_status: 0)}
  scope :employee_users, ->{where.not(user_roles: 0).where.not(user_roles: 6).where.not(activity_status: 0) }
  scope :customer_users, ->{where(user_roles: 0).where.not(activity_status: 0) }
  scope :pending_users, ->{where(activity_status: 0) }
  scope :developer_users, ->{where(user_roles: 1) }
  scope :architect_users, ->{where(user_roles: 2) }
  scope :hr_users, ->{where(user_roles: 3) }
  scope :management_users, ->{where(user_roles: 4) }
  scope :accountant_users, ->{where(user_roles: 5) }



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
    vendor:        6

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
