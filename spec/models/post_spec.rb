require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:post) { FactoryBot.create(:post_with_picture) }
	it { should belong_to(:user) }


	describe 'picture' do
		it 'should have a picture' do
			expect(post.picture).to be_instance_of(PictureUploader)
		end        
	end
end
