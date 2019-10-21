class Post < ApplicationRecord
  default_scope { order('created_at DESC') }
  include ActionView::Helpers::DateHelper
  scope :newest, -> { order(created_at: :desc) }
  belongs_to :user 
  belongs_to :camera, touch: :last_post_at
  before_validation :set_camera
  after_validation :reverse_geocode
  before_destroy :delete_orphaned_camera
  attr_accessor :ip_code

  mount_uploader :picture, PictureUploader

  reverse_geocoded_by :latitude, :longitude do |obj, results| 
    geo = results.first
    if geo.present? && geo.data["error"].nil?
      obj.address = geo.address
      obj.city = geo.city if geo.city
    end
  end

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

  def set_camera
    self.camera = Camera.search(where: geo_query, limit: 1).first
    self.camera = Camera.new(
      latitude: latitude, 
      longitude: longitude
    ) unless camera
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
  def delete_orphaned_camera
    camera.destroy if last_post
  end

  def last_post
    camera.posts.size == 1
  end
end
