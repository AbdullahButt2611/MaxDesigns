class Project < ApplicationRecord
	#=========================	Associations 	===========================================
	has_many :project_details, dependent: :destroy

	has_many :orders, dependent: :destroy
	
	has_many :amount_receiveds, dependent: :destroy



	#=======================		Scopes		==========================================
	scope :not_completed_projects, ->{ where.not(project_status: "completed") and order('updated_at DESC')}


	#=======================	 Validations	===========================================
	number_regex = /\d[0-9]\)*\z/


	validates :name, presence: true, uniqueness: true, length: { minimum: 2 }
	validates :client_name, presence: true,
		       format: { with: /^[a-zA-Z ]*$/, message: 'Can only contain letter and white spaces',multiline: true },
		       length: { minimum: 2 }
    validates_format_of :contact, :with =>  number_regex, :message => "Only positive number without spaces are allowed"
    validates :contact, presence: true, uniqueness: true,  length: { minimum: 11, maximum: 11 }
    validates :location, presence: true, uniqueness: true
    validates :amount_promised, presence: true, numericality: {greater_than_or_equal_to: 20000 }
    validates :amount_present, presence: true, numericality: {greater_than_or_equal_to: 0 }



	#===========================	 Enum declarations		===================================
  	enum project_type: {
	    completely_build: 0,
	    interior_design: 1,
	    finishing: 2,
	    renovation: 3,
	    structure_building: 4
  	}

  	enum project_status: {
	    enqueued: 0,
	    in_progress: 1,
	    final_stage: 2,
	    completed: 3,
  	}

end