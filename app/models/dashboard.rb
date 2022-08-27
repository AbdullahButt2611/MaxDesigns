class Dashboard < ApplicationRecord
	before_action :authenticate_user!
end