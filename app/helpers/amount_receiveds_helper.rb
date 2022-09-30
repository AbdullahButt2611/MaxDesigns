module AmountReceivedsHelper

	def find_project(amount_data_id)
		project = Project.find(amount_data_id) 
	end
	
end