class OrderDetail < ApplicationRecord
    belongs_to :order

    validates :quantity, numericality: { less_than_or_equal_to: 1, only_integer: true }

    
end