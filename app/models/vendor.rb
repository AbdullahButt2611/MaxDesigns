class Vendor < ApplicationRecord
	before_action: authenticate_user!
end