json.extract! post, :id, :description, :created_at, :updated_at, :user_id, :picture, :latitude, :longitude, :city, :video
location = post.location
forecast_hash = {}
forecast_hash = { tideChart: location.forecast.tideChart, hourly: location.hourly, daily: location.daily  } if location.forecast.current
location = { name: location.name, latitude: location.latitude, longitude: location.longitude, forecast: forecast_hash } 
json.location location
json.liked post.liked(current_user.id)
json.date post.creation_date
json.url post_url(post, format: :json)
