class LocationSerializer
  include FastJsonapi::ObjectSerializer
  has_many :cameras, if: Proc.new {|record, params| params && params[:with_cameras] == true }
  # has_many :posts, if: Proc.new {|record, params| params && params[:with_cameras] == true }
  attributes :id, :direction, :experience, 
    :frequency, :bottom, :wave_quality, 
    :name, :latitude, :longitude, :address, 
    :with_forecast, :best_wind_direction, 
    :best_swell_direction, :forecast_info, 
    :last_camera_at

  attribute :forecast_info do |object|
    { 
      tide: object.forecast_tide, 
      hourly: object.forecast_hourly, 
      daily: object.forecast_daily 
    } 
  end

  attribute :distance do |object, params|
    object.distance_from_user(params[:gps]) if params[:gps].present?
  end
end
