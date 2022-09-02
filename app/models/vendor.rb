class Vendor < ApplicationRecord

	# Associations
	belongs_to :user, optional: true
    has_many :items

    validates :company_name, presence: true, length: { minimum: 2 }
    validates :address, presence: true, length: { minimum: 5 }



	# Enum Declarations
	enum company_type: {
    lamp: 0,
    marble: 1,
    transport: 2,
    paint: 3,
    wood: 4
  }

end