class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :direction, :experience, :frequency, :bottom, :wave_quality, 
    :name, :latitude, :longitude, :country, :area, :address,
    :with_forecast, :best_wind_direction, :best_swell_direction

  attribute :forecast_info do |object|
    forecast = object.forecast
    { 
      tide: forecast.tide, 
      hourly: forecast.hourly, 
      daily: forecast.daily 
    } if forecast
  end

  attribute :distance do |object, params|
    object.distance_from_user(params[:gps]) if params[:gps].present?
  end
end
