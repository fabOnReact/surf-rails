class Post < ApplicationRecord
	validates :stars, numericality: { only_integer: true }
end
