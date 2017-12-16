class Post < ApplicationRecord
	belongs_to :user
  attr_accessor :ip_code

	mount_uploader :picture, PictureUploader
  geocoded_by :ip_code, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode
end
