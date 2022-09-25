class Order < ApplicationRecord
    belongs_to :project, touch: true
    has_many :order_details, dependent: :destroy

    validates :order_date, presence: true
    validates :order_type, presence: true
    validates :project_id, presence: true

    scope :all_order, -> {Order.all}
    scope :unpaid_order, -> {where(order_type: 0)}
    scope :paid_order, -> {where(order_type: 1)}


    enum order_type: {
        unpaid: 0,
        paid: 1,
      }

      

    
    
end