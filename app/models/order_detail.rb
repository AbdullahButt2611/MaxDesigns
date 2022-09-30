class OrderDetail < ApplicationRecord
    
    #==========================         Associations    =======================================
    belongs_to :order, touch: true

    
    
    #==========================         Validations    =======================================
    validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
    validates :item_id, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
    validate  :item_in_vendor
    


    
    #==========================       Functions       =======================================
    private 

    def item_in_vendor
        vendor = Vendor.find_by_id(vendor_id)
        if not vendor.items.find_by_id(item_id)
            errors.add(:item_id, {message: " is not present for this vendor"})
        end
    end



    
end