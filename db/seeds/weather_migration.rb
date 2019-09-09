# locations = Location.where(forecast: nil)
# locations.update_all(with_forecast: false)
# locations = Location.where.not(forecast: nil)
# locations.update_all(with_forecast: true)

locations = Location.where(with_forecast: true)

locations.each do |location|
  Forecast.create(
    location_id: location.id, 
    weather: location.forecast_data,
    tides: location.tides,
    daily: location.forecast_daily,
    hourly: location.forecast_hourly,
    tide: location.forecast_tide
  )
end
