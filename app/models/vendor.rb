class Vendor < ApplicationRecord

	# Associations
	  belongs_to :user, optional: true, touch: true
    has_many :items, dependent: :destroy

    scope :all_vendors, -> {Vendor.pluck(:company_name)}

    validates :company_name, presence: true, length: { minimum: 2 }
    validates :address, presence: true, length: { minimum: 5 }



	# Enum Declarations
	enum company_type: {
    different: 0,
    marble: 1,
    transport: 2,
    paint: 3,
    wood: 4,
    lamp: 5
  }

end