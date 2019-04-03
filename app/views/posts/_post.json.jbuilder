json.extract! post, :id, :description, :created_at, :updated_at, :user_id, :picture, :latitude, :longitude, :city
json.date "#{time_ago_in_words(post.created_at)} ago"
json.url post_url(post, format: :json)
