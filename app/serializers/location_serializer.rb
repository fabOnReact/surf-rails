class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :direction, :experience, :frequency, :bottom, :wave_quality, 
    :name, :latitude, :longitude, :address, :with_forecast, :best_wind_direction, 
    :best_swell_direction, :forecast_info

  attribute :forecast_info do |object|
    forecast = object.forecast
    if forecast.present?
      { 
        tide: forecast.tide, 
        hourly: forecast.hourly, 
        daily: forecast.daily 
      } 
    end
  end

  attribute :distance do |object, params|
    object.distance_from_user(params[:gps]) if params[:gps].present?
  end
end
