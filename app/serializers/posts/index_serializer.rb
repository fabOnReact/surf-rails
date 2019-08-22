class Posts::IndexSerializer < PostSerializer
  def forecast
    { tideChart: object.location.forecast.tideChart, hourly: object.location.hourly, daily: object.location.daily  } if object.location.forecast.current
  end
end
