module ProjectsHelper

	def project_deadline_formatiing(my_date)
		require 'date'
		# str =  Date::MONTHNAMES[date_obj.month]  +" "+date_obj.day.to_s+", "+date_obj.year.to_s
		return Date::MONTHNAMES[my_date.month]+" "+my_date.day.to_s+", "+my_date.year.to_s
		return my_date
	end

	def find_item(vendor_id, item_id)
		vendor = Vendor.find(vendor_id)
		item = vendor.items.find(item_id)
		return item
	end

	def find_vendor(vendor_id)
		vendor = Vendor.find(vendor_id)
		return vendor.company_name
	end

	def sum_price_calculator(vendor_id, item_id, quantity)
		vendor = Vendor.find(vendor_id)
		item = vendor.items.find(item_id)
		sum = item.price * quantity
		return sum
	end

	def calculate_total_sum_of_order(order)
		price = 0
		order.order_details.each do |detail|
			item = find_item(detail.vendor_id, detail.item_id)
			value = item.price * detail.quantity
			price += value
		end
		return price
	end
end