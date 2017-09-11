module Mp3Helper
	def seconds_to_minutes value, hash = false
		value = value.to_i
		minutes = value/60
		seconds = value-(minutes*60)
		if hash == true
			return {
				:min => minutes,
				:sec => seconds
			}
		else
			case seconds
			when 0
				seconds = "00"
			when 1
				seconds = "01"
			when 2
				seconds = "02"
			when 3
				seconds = "03"
			when 4
				seconds = "04"
			when 5
				seconds = "05"
			when 6
				seconds = "06"
			when 7
				seconds = "07"
			when 8
				seconds = "08"
			when 9
				seconds = "09"
			end
			return "#{minutes}:#{seconds}"
		end
	end
end
