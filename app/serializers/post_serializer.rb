class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :created_at, :updated_at, :user_id, :latitude, 
    :longitude, :city, :creation_date, :video, :picture #, :location

  # attribute :location do  |object|
  #   forecast = object.location.forecast
  #   forecast_value = { 
  #     tide: forecast.tide, 
  #     hourly: forecast.hourly, 
  #     daily: forecast.daily, 
  #     tide_data: forecast.tide_data 
  #   } if forecast.present?
  #   { 
  #     name: object.location.name, latitude: object.location.latitude, 
  #     longitude: object.location.longitude, forecast_info: forecast_value 
  #   } 
  # end
end
