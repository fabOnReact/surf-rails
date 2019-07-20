json.extract! location, :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address
latlong = { longitude: location.longitude, latitude: location.latitude }
json.distance location.distance_from_user(params.gps)
json.location latlong
json.forecast location.current_forecast
