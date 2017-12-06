FactoryBot.define do 
	factory :picture_uploader do
		after :create do |b|
			b.update_column(:photo, "foo/bar/baz.png")
		end
 	end
end