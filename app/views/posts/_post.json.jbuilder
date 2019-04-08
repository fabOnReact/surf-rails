json.extract! post, :id, :description, :created_at, :updated_at, :user_id, :picture, :latitude, :longitude, :city, :likes
json.date post.creation_date
json.url post_url(post, format: :json)
