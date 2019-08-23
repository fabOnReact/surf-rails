class LocationsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address, :longitude, :latitude

  attribute :forecast do |object|
    { tide: object.forecast.tideChart, hourly: object.hourly, daily: object.daily }
  end

  attribute :distance do |object|
    object.distance_from_user(params.gps) if params.gps?
  end
end
