class OrderDetail < ApplicationRecord
    belongs_to :order, touch: true

    validates :quantity, numericality: { greater_than_or_equal_to: 1, only_integer: true }

    
end