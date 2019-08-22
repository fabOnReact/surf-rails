class Posts::IndexSerializer < PostSerializer
  attributes :id, :description, :created_at, :updated_at, :user_id, :latitude, :longitude, :city, :video, :forecast, :creation_date
  def forecast
    { tideChart: object.location.forecast.tideChart, hourly: object.location.hourly, daily: object.location.daily  } if object.location.forecast.current
  end
end
