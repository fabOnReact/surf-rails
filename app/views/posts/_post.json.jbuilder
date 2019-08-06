json.extract! post, :id, :description, :created_at, :updated_at, :user_id, :picture, :latitude, :longitude, :city
location = post.location
location = { name: location.name, forecast: location.forecast.json, latitude: location.latitude, longitude: location.longitude } 
json.location location
json.liked post.liked(current_user.id)
json.date post.creation_date
json.url post_url(post, format: :json)
