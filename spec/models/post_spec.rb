require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:location) { FactoryBot.create(:location, latitude: -8, longitude: 115, forecast: ["do not trigger callback"]) }
  let(:post) { FactoryBot.create(:post_with_picture, latitude: -8, longitude: 115) }
  it { should belong_to(:user) }

  before { location }

  describe '#reverse_geocoding' do
  	it 'should save the location of the user' do
      expect(post.address).to be_present
  	end
  end

  describe 'picture' do
    it 'should have a picture' do
      expect(post.picture).to be_instance_of(PictureUploader)
    end        
  end
end
