class Camera < ApplicationRecord
  searchkick locations: [:location]
  default_scope { order('last_post_at DESC') }
  belongs_to :location, touch: :last_camera_at
  has_many :posts, dependent: :destroy
  before_validation :set_location
  before_save :set_last_post_at
  after_create :update_forecast
  before_destroy :update_with_cameras
  validates_associated :location, :message => "Looks like you are very far from any surf destination, only videos that are taken at a surfspot present in our database are accepted. Sorry!"

  def set_last_post_at
    self.last_post_at = DateTime.now
  end

  def search_data
    attributes.merge(location: {lat: latitude, lon: longitude})
  end

  def coords
    [latitude, longitude]
  end

  def set_location
    self.location = Location.near(coords, 30).limit(1).first
  end

  def update_forecast
    location.set_job unless location.with_forecast
    location.update(with_cameras: true) unless location.with_cameras
  end

  private
  def update_with_cameras
    location.update(with_cameras: false) if last_camera
  end

  def last_camera
    location.cameras.size == 1
  end
end
