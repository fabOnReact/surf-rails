require 'rails_helper'
require 'api/storm_glass'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location, latitude: 1, longitude: 1) }
  let(:hour1) do 
    { "hour"=> 1, "waveHeight"=> [{ "value" => 1}, { "value" => 2 }] }
  end

  let(:hour2) do 
    { "hour"=> 1, "waveHeight"=> [{ "value" => 3}, { "value" => 4 }] }
  end

  let(:forecast) { [ hour1, hour2 ] }

  describe "#set_forecast" do 
    it "triggers and records a job" do
    end
  end

  describe "#upcomingWaves" do 
    it "returns the average wave height for each hour" do
      allow(location).to receive(:upcoming_forecast).and_return(forecast)
      expect(location.upcomingWaves).to eql [1.5, 3.5]
    end
  end
end
