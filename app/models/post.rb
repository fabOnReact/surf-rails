class Post < ApplicationRecord
	belongs_to :user
  attr_accessor :ip_code

	mount_uploader :picture, PictureUploader
  #reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode
end
