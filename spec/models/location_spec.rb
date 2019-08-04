require 'rails_helper'
require 'api/storm'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location, latitude: 1, longitude: 1) }
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

  describe "#forecast" do 
    it "returns the forecast object" do 
      expect(location.forecast.class).not_to be Array
      expect(location.forecast.class).to be Forecast
    end
  end
end
