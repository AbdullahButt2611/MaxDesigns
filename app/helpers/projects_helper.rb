module ProjectsHelper


	# Date Formatter: "October 13, 2022"
	def project_deadline_formatiing(my_date)
		require 'date'
		# str =  Date::MONTHNAMES[date_obj.month]  +" "+date_obj.day.to_s+", "+date_obj.year.to_s
		return Date::MONTHNAMES[my_date.month]+" "+my_date.day.to_s+", "+my_date.year.to_s
		return my_date
	end



	# Function to calculate the sum of all the orders relative to their order details
	def calculate_total_sum_of_all_orders(project)
		price = 0
		project.orders.each do |order|
			if order.order_type == "paid"
				value = calculate_total_sum_of_order(order)
				price += value
			end
		end
		return price
	end




	# Method to identify the amount received till date.
	def calculate_total_sum_of_amount_details(project)
		price = 0
		project.amount_receiveds.each do |detail|
			item = detail.money_received
			price += item
		end
		return price
	end


end