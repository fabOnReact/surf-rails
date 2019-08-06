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

  describe '#set_forecast' do 
    it 'will set forecast information' do
      forecast_data = [{"waveHeight"=> [{"source"=> "msw", "height"=> 10}, {"source"=> "other", "height"=> 1}]}, "waveDirection"=> [{"source"=> "msw", "direction"=> 0}]]
      tide = instance_double("tide")
      allow_any_instance_of(Storm).to receive(:getWaveForecast).and_return(forecast_data)
      allow_any_instance_of(Storm).to receive(:getTide).and_return(tide)
      location = FactoryBot.create(:location, latitude: -8, longitude: 115)
      allow_any_instance_of(Post).to receive(:location).and_return(location)
      location = FactoryBot.create(:location, latitude: -8, longitude: 115)
      forecast = post.location.forecast
      expect(forecast).to be_present
      expect(forecast.first["waveHeight"].size).to be > 0
      expect(forecast.class).to be Forecast
    end
  end
end
