class Post < ApplicationRecord
	scope :newest, -> { order(created_at: :desc) }

	belongs_to :user
  attr_accessor :ip_code

	mount_uploader :picture, PictureUploader
  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode

  def utc_date
  	self.created_at.utc
  end  

  def owner?(user)
  	self.user == user
  end      
end
