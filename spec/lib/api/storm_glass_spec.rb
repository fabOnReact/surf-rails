require 'rails_helper'
require 'api/storm_glass'

describe StormGlass do 
  let(:storm) { StormGlass.new('-8.720425','115.169207') } 
  let(:date) { DateTime.new(2019, 07, 10, 02, 00, 00) }
  let(:error) {{"errors": "Maximum number of calls reached"}}

  describe '#timestamp' do 
    it 'returns the correct format' do
      allow(DateTime).to receive(:now).and_return(date)
      expect(storm.timestamp).to eql "2019-07-10T13:00:00+00:00"
    end
  end

  describe '#getWeather' do
    it 'retrieves the results' do 
      expect(storm.getWeather["hours"].size).to be > 0
    end

    it 'queries the next 12 hours of forecast' do
      expect(storm.getWeather["hours"].size).to be 25
    end
  end

  describe '#getWaveForecast' do 
    context "with sucessfull api response" do
      before { @keys = storm.getWaveForecast[0].keys }
      it 'retrieves the wave forecast for every hour'

      it 'return wave swell/wave height, period, direction and wind speed/direction' do
        expect(@keys).to match_array StormGlass::FIELDS 
      end

      it 'deletes any other info' do
        expect(@keys).not_to include "iceCover"
      end

      it 'returns an array' do
        expect(storm.getWaveForecast.class).to be Array
      end
    end

    context 'when the api fails' do
      it 'returns null object if api fails' do
        allow(storm).to receive(:weather).and_return(error)
        expect(storm.getWaveForecast).to be nil
      end
    end
  end

  describe "#getWeather" do
    it 'returns ApiError for failures' do 
      allow(storm).to receive(:weather).and_return(error)
      expect(storm.getWeather.class).to be ApiError
    end
  end
end
