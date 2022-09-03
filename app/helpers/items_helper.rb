module ItemsHelper

	def item_update_date_formatting(dateValue)
		timeString = distance_of_time_in_words(dateValue, Time.now)
		timeString.capitalize
	end
end