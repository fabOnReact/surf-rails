require 'rails_helper'
require 'api/storm'

RSpec.describe Location, type: :model do
  subject { Location.new }
  let(:location) { FactoryBot.build(:location, latitude: 1, longitude: 1) }
  let(:storm) { instance_double("storm") }
  let(:forecast) { instance_double("forecast", daily: day_forecast) }
  let(:day_forecast) { instance_double("Forecast", "day_forecast", size: 4) }
  let(:timezone) { instance_double("timezone") }
  let(:day) { instance_double("day") }

  context "mocking forecast class" do
    before do
      allow(location).to receive(:storm).and_return storm
      allow(storm).to receive(:getWaveForecast).and_return forecast
      allow(storm).to receive(:getTide).and_return forecast
      allow(Forecast).to receive(:new).and_return forecast
      location.save
    end

    describe "mocking callbacks" do
      it "will prevent api calls and return instance_doubles" do
        expect(location.forecast).to eql forecast
      end
    end
  end


  describe '#get_daily_forecast' do
    subject { FactoryBot.build(:location, forecast: forecast, timezone: timezone) }
    let(:day_in_word) { instance_double("day_in_word") }
    it 'returns the weekly forecast' do
      allow_any_instance_of(DateTime).to receive(:in_time_zone)
        .and_return(day)
      allow(day).to receive_message_chain(:to_datetime, :strftime)
        .and_return(day_in_word)
      allow(Forecast).to receive(:new).and_return forecast
      result = subject.get_daily_forecast
      expect(result["days"].size).to be 4
      expect(result["days"]).to include(day_in_word)
      expect(result["swellHeight"]).to be day_forecast
    end
  end
end
