class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user
  after_validation :reverse_geocode
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
end
