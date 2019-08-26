class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :direction, :experience, :frequency, :bottom, :wave_quality, :name, :latitude, :longitude, :country, :area, :address, :longitude, :latitude, :with_forecast

  attribute :forecast_info do |object|
    { tide: object.forecast_tide, hourly: object.forecast_hourly, daily: object.forecast_daily } if object.with_forecast
  end

  attribute :distance do |object, params|
    object.distance_from_user(params[:gps]) if params[:gps].present?
  end
end
