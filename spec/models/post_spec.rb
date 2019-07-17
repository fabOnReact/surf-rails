require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post_with_picture) }
  it { should belong_to(:user) }

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

  describe '#set_forecast' do 
    it 'will set forecast information' do
      location = FactoryBot.create(:location)
      forecast_data = [{"waveHeight"=> [{"source"=> "msw", "height"=> 10}, {"source"=> "other", "height"=> 1}]}, "waveDirection"=> [{"source"=> "msw", "direction"=> 0}]]
      allow_any_instance_of(Post).to receive(:location).and_return(location)
      allow_any_instance_of(StormGlass).to receive(:getWaveForecast).and_return(forecast_data)
      forecast = post.location.forecast
      expect(forecast).to be_present
      expect(forecast).to eql forecast_data
      expect(forecast.class).to be Array
    end
  end
end
