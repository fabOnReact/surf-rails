class Post < ApplicationRecord
  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user
  attr_accessor :ip_code

  mount_uploader :picture, PictureUploader

  # reverse_geocoded_by :latitude, :longitude, address: :location
  reverse_geocoded_by :latitude, :longitude do |obj, results| 
    if geo = results.first
      obj.location = geo.city
    end
  end

  # after_validation :fetch_address
  after_validation :reverse_geocode

  def creation_date
    created_at.strftime("%B %d, %Y, %A")
  end

  def utc_date
    created_at.utc
  end

  def owner?(owner)
    user == owner
  end
end
