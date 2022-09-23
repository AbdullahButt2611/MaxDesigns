class Transaction < ApplicationRecord
    #==========================         Associations    =======================================
    belongs_to :order, touch: true
    
    
    #==========================         Scopes    =======================================
    scope :current_users_transactions_added, ->(id) { where(user_id: id).order('created_at DESC')}


    #==========================         Validations    =======================================
    validates :amount_paid, presence: true, numericality: {greater_than_or_equal_to: 0 }
    validates :date, presence: true
    validate  :date_is_date?


    #==========================       Functions       =======================================
    private

    def date_is_date?
        if !date.is_a?(DateTime) and !date.is_a?(ActiveSupport::TimeWithZone)
            errors.add(:date, 'must be a valid datetime') 
        end
    end

end