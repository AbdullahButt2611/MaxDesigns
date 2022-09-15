class Order < ApplicationRecord
    belongs_to :project
    has_many :order_details
end