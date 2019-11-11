class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :user 
  belongs_to :camera, touch: :last_post_at
  before_validation :set_or_initialize_camera, :set_forecast
  after_validation :reverse_geocode
  attr_accessor :ip_code
  scope :newest, -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  reverse_geocoded_by :latitude, :longitude do |obj, results| 
    geo = results.first
    if geo.present? && geo.data["error"].nil?
      obj.address = geo.address
      obj.city = geo.city if geo.city
    end
  end

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
  def geo_query 
    { 
      location: 
        { 
          near: 
            { 
              lat: latitude, 
              lon: longitude
            }, 
          within: "1km"
        }
    }
  end

  def set_forecast
    self.forecast = camera.location.forecast_hourly
  end

  def set_camera
    self.camera = Camera.search(where: geo_query, limit: 1).first
  end

  def coords
    [latitude, longitude]
  end

  def initialize_camera
    location = Location.near(coords, 30).limit(1).first
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
