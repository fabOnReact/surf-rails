class PostSerializer < ActiveModel::Serializer
  has_one :picture
  attributes :id, :description, :created_at, :updated_at, :user_id, :latitude, :longitude, :city, :location, :creation_date, :video

  def location
    { name: object.location.name, latitude: object.location.latitude, longitude: object.location.longitude, forecast: forecast } 
  end

  def forecast
    { tide: object.location.forecast.tideChart, hourly: object.location.hourly, daily: object.location.daily  } if object.location.forecast.current
  end
end
