class Order < ApplicationRecord
    belongs_to :project
    has_many :order_details

    validates :order_date, presence :true
    validates :order_type, presence :true
    validates :project_id, presence :true


    enum order_type: {
        unpaid: 0,
        paid: 1,
      }
end