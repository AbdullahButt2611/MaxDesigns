class Order < ApplicationRecord
  
  #==========================         Associations    =======================================
  belongs_to :project, touch: true
  has_many :order_details, dependent: :destroy





  #==========================         Validations    =======================================
  validates :order_date, presence: true
  validates :order_type, presence: true
  validates :project_id, presence: true





  #==========================         Scopes    =======================================
  scope :all_order, -> {Order.all}
  scope :unpaid_order, -> {where(order_type: 0)}
  scope :paid_order, -> {where(order_type: 1)}

  



  #==========================         Enum Declaration    =======================================
  enum order_type: {
    unpaid: 0,
    paid: 1,
  }


   

      

    
    
end