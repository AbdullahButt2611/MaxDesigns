class Vendor < ApplicationRecord

	# Associations
	belongs_to :user, optional: true





	# Enum Declarations
	enum company_type: {
    lamp: 0,
    marble: 1,
    transport: 2,
    paint: 3,
    wood: 4
  }

end