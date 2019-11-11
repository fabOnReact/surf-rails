class Camera < ApplicationRecord
  default_scope { newest }
  belongs_to :location, touch: :last_camera_at
  has_many :posts
  before_validation :set_location
  after_validation :reverse_geocode, if: ->(obj){ valid_coordinates(obj) }
  validates_associated :location, :message => "Looks like you are very far from any surf destination, only videos that are taken at a surfspot present in our database are accepted. Sorry!"
  scope :with_posts, -> { includes(:posts).where("posts.flagged" => false) }
  scope :newest, -> { order('last_post_at DESC') }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def coords
    [latitude, longitude]
  end

  def set_location
    self.location = Location.near(coords, 5, units: :km).limit(1).first
  end
end
