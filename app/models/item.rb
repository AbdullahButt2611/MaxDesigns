class Item < ApplicationRecord
	belongs_to :vendor, touch: true

	scope :item_based_on_type, ->(type) {where(item_type: type)}

	validates :name, presence: true
	validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }

	# Enum Declarations
	enum item_type: {
	    unclassified: 0,
	    marble: 1,
	    wallpapers: 2,
	    paint: 3,
	    wood: 4,
	    lamp: 5,
	    glass: 6,
	    polymer: 7
	 }
end