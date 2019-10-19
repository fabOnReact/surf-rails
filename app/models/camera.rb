class Camera < ApplicationRecord
  searchkick locations: [:location]
  belongs_to :location
  has_many :posts
  before_validation :set_location
  after_create :update_forecast
  validates_associated :location, :message => "Looks like you are very far from any surf destination, only videos that are taken at a surfspot present in our database are accepted. Sorry!"

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
  end
end
