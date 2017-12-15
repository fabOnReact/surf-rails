require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:post) { FactoryBot.create(:post_with_picture) }
	it { should belong_to(:user) }

  describe ':set_ip() and :get_ip' do
    it 'should set and return the ip' #do
      #post.set_ip('127.0.0.1')
      #expect(post.get_ip).to eql('127.0.0.1')
    #end
  end

	describe 'picture' do
		it 'should have a picture' do
			expect(post.picture).to be_instance_of(PictureUploader)
		end        
	end
end
