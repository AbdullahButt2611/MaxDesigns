class AmountReceived < ApplicationRecord
    #==========================         Associations    =======================================
    belongs_to :project, touch: true
    


    


    
    #==========================         Validations    =======================================
    validates :money_received, presence: true, numericality: {greater_than_or_equal_to: 0 }
    validates :mode, presence: true
    validates :purpose, presence: true,  length: { minimum: 5 }
    validates :date, presence: true
    validate  :date_is_date?
    
    


    
    
    #==========================         Before Actions    =======================================
    before_validation :set_date_time_value
    
    
    




    #==========================         Scopes    =======================================
    scope :current_users_amounts_added, ->(id) { where(user_id: id).order('created_at DESC')}
    scope :projects_users_amounts_added, ->(user_id, project_id) { where(user_id: user_id, project_id: project_id) and order('created_at DESC')}
   






    #==========================         Enum Declaration    =======================================
    enum mode: {
	    cash: 0,
	    cheque: 1
  	}




    #==========================       Functions       =======================================
    private

    # Custom Validator for Date to be a proper formatted date.
    def date_is_date?
        if !date.is_a?(DateTime) and !date.is_a?(ActiveSupport::TimeWithZone)
            errors.add(:date, 'must be a valid datetime') 
        end
    end




    # Function used to set the date time before saving the data
    def set_date_time_value
        self.date = DateTime.now
    end




    

end