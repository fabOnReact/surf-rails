json.extract! location, :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address
latlong = { longitude: location.longitude, latitude: location.latitude }
json.location latlong
