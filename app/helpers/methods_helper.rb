module MethodsHelper

	# Date Formatter: September 30, 2022
	def order_date_formatiing(my_date)
		require 'date'
		# str =  Date::MONTHNAMES[date_obj.month]  +" "+date_obj.day.to_s+", "+date_obj.year.to_s
		return Date::MONTHNAMES[my_date.month]+" "+my_date.day.to_s+", "+my_date.year.to_s
		return my_date
	end





	#  This method will find the item in the vendor's item list and return the complete data/
	def find_item(vendor_id, item_id)
		vendor = Vendor.find(vendor_id)
		item = vendor.items.find(item_id)
		return item
	end




	# Function to find the vendor's company name just by vendor's id
	def find_vendor(vendor_id)
		vendor = Vendor.find(vendor_id)
		return vendor.company_name
	end




	# Function to find the vendor's complete data just by vendor's id
	def find_vendor_as_object(vendor_id)
		vendor = Vendor.find(vendor_id)
		return vendor
	end





	# Function to find the total proce payable for each item ordered relative to the quantity
	def sum_price_calculator(vendor_id, item_id, quantity)
		vendor = Vendor.find(vendor_id)
		item = vendor.items.find(item_id)
		sum = item.price * quantity
		return sum
	end





	# Function to calculate the total sum in each order, from the items ordered relative to the quantity
	def calculate_total_sum_of_order(order)
		price = 0
		order.order_details.each do |detail|
			item = find_item(detail.vendor_id, detail.item_id)
			value = item.price * detail.quantity
			price += value
		end
		return price
	end




	# This function calculates the total amount payable to each vendor relative to each order.
	def vendor_based_calculation(details)
		counts = Hash.new

		details.each do |detail|
			if counts.key?(detail.vendor_id)
				counts[detail.vendor_id] = counts.fetch(detail.vendor_id) + sum_price_calculator(detail.vendor_id, detail.item_id, detail.quantity)
			else 
				counts.store(detail.vendor_id, sum_price_calculator(detail.vendor_id, detail.item_id, detail.quantity))
			end
		end
		return counts
	end




	# Return the time, the item was updated in words, formatted as: About 1 hour
	def item_update_date_formatting(dateValue)
		timeString = distance_of_time_in_words(dateValue, Time.now)
		timeString.capitalize
	end



	# Date Formatter: September 30, 2022 02:39:25
	def amount_date_formatiing(datetime)
		require 'date'
		my_date = Date::MONTHNAMES[datetime.month]+" "+datetime.day.to_s+", "+datetime.year.to_s
        my_time = datetime.strftime('%H:%M:%S')
		return my_date + "  " + my_time
	end

end