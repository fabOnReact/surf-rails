class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  scope :newest, -> { order(created_at: :desc) }

  belongs_to :user 
  belongs_to :location
  before_save :set_additional_data
  after_create :update_forecast
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

  def set_additional_data
    self.location = Location.near([self.latitude, self.longitude], 8).limit(1).first
    self.location_data = { name: self.location.name }
  end

  def update_forecast
    self.location.set_job unless self.location.with_forecast
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
