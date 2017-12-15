class Post < ApplicationRecord
	belongs_to :user
  attr_accessor :ip_code

	mount_uploader :picture, PictureUploader
  geocoded_by :ip_code, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode

  #def set_ip(ip)
    #@ip_address = ip
  #end

  #def get_ip
    #@ip_address
  #end
end
