$time = Time.now.strftime("%s").to_i
$datetime = DateTime.now.in_time_zone(Rails.application.config.time_zone)
