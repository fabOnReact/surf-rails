class Post < ApplicationRecord
	belongs_to :user
	mount_uploader :picture, PictureUploader
  geocoded_by :ip_address, :latitude => :lat, :longitude => :lon
  after_validation :geocode

  def ip_address
    #if request.remote_ip == '127.0.0.1'
      #'98.236.166.116'
    #else
      #request.remote_ip
    #end
  end  
end
