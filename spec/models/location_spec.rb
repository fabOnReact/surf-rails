require 'rails_helper'
require 'webmock/rspec'
require 'api/storm'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location, latitude: 1, longitude: 1) }

  describe "stubbing an http request with webmock" do
    it "returns the correct body" do
      stub_request(:any, /www.example.com/).to_return(body: "test")
      response = Net::HTTP.get("www.example.com", "/")
      expect(response).to eql "test"
    end
  end

  describe "#set_forecast" do 
    it "triggers and records a job" do
    end
  end

  describe "#upcomingWaves" do 
    it "returns the average wave height for each hour" do
      stub_request(:any, /api.stormglass.io/).to_return(body: "test")
      stub_request(:get, /nominatim.openstreetmap.org/).to_return(body: "test1")
      allow(location).to receive(:upcoming_forecast).and_return(forecast)
      expect(location.upcomingWaves).to eql [1.5, 3.5]
    end
  end

  describe "#forecast" do 
    it "returns the forecast object" do 
      expect(location.forecast.class).not_to be Array
      expect(location.forecast.class).to be Forecast
    end
  end

  describe "#weeklyForecast" do 
    it "retrieves the weekly waveHeight forecast" do

    end
  end
end
