class Post < ApplicationRecord
  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user
  after_validation :reverse_geocode
  attr_accessor :ip_code

  mount_uploader :picture, PictureUploader

  reverse_geocoded_by :latitude, :longitude do |obj, results| 
    if geo = results.first
      obj.address = geo.address
      obj.city = geo.city
    end
  end

  def creation_date
    "#{time_ago_in_words(created_at)} ago"
  end

  def utc_date
    created_at.utc
  end

  def owner?(owner)
    user == owner
  end
end
