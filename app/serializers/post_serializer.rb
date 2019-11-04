class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :created_at, 
    :updated_at, :user_id, :latitude, 
    :longitude, :city, :creation_date, 
    :video, :picture, :forecast, :creation_date
end
