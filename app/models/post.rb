class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :user 
  belongs_to :camera, touch: :last_post_at
  before_validation :set_or_initialize_camera
  before_save :set_forecast
  attr_accessor :ip_code
  scope :newest, -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader
  def liked(user_id)
    favorite.include? user_id
  end

  def creation_date
    "#{time_ago_in_words created_at} ago"
  end

  def utc_date
    created_at.utc
  end

  def owner?(owner)
    user == owner
  end

  private
  def set_forecast
    location = self.camera.location
    location.set_job unless location.with_forecast
  end

  def set_camera
    self.camera = Camera.near([latitude, longitude], 0.1, units: :km).first
  end

  def coords
    [latitude, longitude]
  end

  def initialize_camera
    location = Location.near(coords, 5, units: :km).limit(1).first
    self.camera = Camera.new(
      latitude: latitude, 
      longitude: longitude,
      location: location,
    )
  end

  def set_or_initialize_camera
    set_camera
    initialize_camera unless camera
  end
end
