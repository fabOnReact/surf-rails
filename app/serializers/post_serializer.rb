class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :created_at, :updated_at, :user_id, :latitude, :longitude, :city, :creation_date, :video, :picture, :location

  attribute :location do  |object|
    forecast_value = { tide: object.location.forecast.forecast_tide, hourly: object.location.forecast_hourly, daily: object.location.forecast_daily  } if object.location.with_forecast
    { name: object.location.name, latitude: object.location.latitude, longitude: object.location.longitude, forecast: forecast_value } 
  end
end
