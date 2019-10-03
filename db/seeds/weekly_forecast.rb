def cron_tab(minute, hour, first_day, second_day, third_day)
  "#{minute} #{hour - 1} * * #{first_day},#{second_day},#{third_day}"
end

locations = Location.where(with_forecast: true)
locations.each do |location|
  job = Sidekiq::Cron::Job.find(
    "Location name: #{location.name}, id: #{location.id} update forecast data - every 3 days"
  )
  next if job.nil?
  params = job.cron.split(" ")
  days = params.last.split(",")
  if days.size < 3 
    minute = params.first.to_i
    hour = params.second.to_i
    first_day = days.first.to_i
    second_day = first_day.next_day
    third_day = second_day.next_day
    location_text = "Location name: #{location.name}, id: #{location.id}"
    job.destroy

    Sidekiq::Cron::Job.load_from_array(
      [
        {
          name: "#{location_text} update forecast data - every 3 days",
          id: "#{location_text} update forecast data - every 3 days",
          cron: cron_tab(minute, hour, first_day, second_day, third_day),
          class: 'WeeklyForecastWorker',
          args: { id: location.id }
        },
      ]
    )
  end
end
