class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user 
  belongs_to :camera
  before_validation :set_camera
  after_validation :reverse_geocode
  attr_accessor :ip_code
  validates_associated :camera, :message => "Looks like you are very far from any surf destination, only videos that are taken at a surfspot present in our database are accepted. Sorry!"

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
end
