module ItemsHelper

	def item_update_date_formatting
		timeString = distance_of_time_in_words(item.updated_at, Time.now)
		timeString.capitalize
	end
end