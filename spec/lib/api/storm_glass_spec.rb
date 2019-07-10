require 'rails_helper'
require 'api/storm_glass'

describe StormGlass do 
  let(:storm) { StormGlass.new('-8.720425','115.169207') } 
  let(:date) { DateTime.new(2019, 07, 10, 02, 00, 00) }

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
      expect(storm.getWeather["hours"].size).to be 12
    end
  end
end
