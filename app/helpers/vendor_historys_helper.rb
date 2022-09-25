module VendorHistorysHelper
    def amount_date_formatiing(datetime)
		require 'date'
		my_date = Date::MONTHNAMES[datetime.month]+" "+datetime.day.to_s+", "+datetime.year.to_s
        my_time = datetime.strftime('%H:%M:%S')
		return my_date + "  " + my_time
	end
end