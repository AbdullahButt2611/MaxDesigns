class VendorsController < ApplicationController



	def index
		if current_user.status == nil
      		current_user.status = 0
      	end
	end
end