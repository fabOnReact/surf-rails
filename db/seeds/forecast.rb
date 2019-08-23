locations = Location.where(forecast: nil)
locations.update_all(with_forecast: false)
locations = Location.where.not(forecast: nil)
locations.update_all(with_forecast: true)
