class VendorHistory < ApplicationRecord
    self.table_name = "vendor_historys"
    #==========================         Associations    =======================================
    belongs_to :vendor, touch: true


    #==========================         Validations    =======================================
    validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0 }
    validates :date, presence: true
    validate  :date_is_date?

    
    
    #==========================       Functions       =======================================
    scope :particular_vendor_history, ->(id) {where(vendor_id: id).order("date ASC")}


    #==========================       Functions       =======================================
    private

    def date_is_date?
        if !date.is_a?(DateTime) and !date.is_a?(ActiveSupport::TimeWithZone)
            errors.add(:date, 'must be a valid datetime') 
        end
    end

    

end