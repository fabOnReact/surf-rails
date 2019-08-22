class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :created_at, :updated_at, :user_id, :latitude, :longitude, :city, :creation_date, :video, :picture, :location

  attribute :location do  |object|
    forecast_value = { tide: object.location.forecast.tideChart, hourly: object.location.hourly, daily: object.location.daily  } if object.location.forecast.current
    { name: object.location.name, latitude: object.location.latitude, longitude: object.location.longitude, forecast: forecast_value } 
  end
end
