json.extract! location, :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address
json.longitude location.longitude
json.latitude location.latitude
json.forecast location.forecast.json
json.distance location.distance_from_user(params.gps) if params.gps?
