class CameraSerializer
  include FastJsonapi::ObjectSerializer
  has_many :posts
  attributes :id, :latitude, :longitude, :rating, :last_post_at, :posts
end
