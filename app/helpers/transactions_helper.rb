module TransactionsHelper

    def amount_date_formatiing(datetime)
		require 'date'
		my_date = Date::MONTHNAMES[datetime.month]+" "+datetime.day.to_s+", "+datetime.year.to_s
        my_time = datetime.strftime('%H:%M:%S')
		return my_date + "  " + my_time
	end

    def find_project_from_order(order_id)
        order = Order.find(order_id)
        project = order.project 
    end

end