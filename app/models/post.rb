class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper
  default_scope -> { where(flagged:false) }
  scope :newest, -> { order(created_at: :desc) }
  belongs_to :user 
  belongs_to :camera, touch: :last_post_at
  before_validation :set_or_initialize_camera, :set_forecast
  after_validation :reverse_geocode
  after_destroy :delete_orphaned_camera
  attr_accessor :ip_code

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

  def delete_orphaned_camera
    camera.destroy if last_post
  end

  def last_post
    camera.posts.empty
  end
end
