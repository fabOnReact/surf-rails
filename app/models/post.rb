class Post < ApplicationRecord
	validates :stars, numericality: { only_integer: true }
	belongs_to :user
	mount_uploader :picture, PictureUploader
end
