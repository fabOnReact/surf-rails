json.extract! location, :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address
json.longitude location.longitude
json.latitude location.latitude
forecast_hash = { tide: location.forecast.tideChart, hourly: location.hourly, daily: location.daily }
json.forecast forecast_hash
json.distance location.distance_from_user(params.gps) if params.gps?
