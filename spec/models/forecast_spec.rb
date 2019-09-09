require 'rails_helper'
require 'weather'

RSpec.describe Forecast, type: :model do
  subject { FactoryBot.build(:forecast, weather: weather) }
  let(:storm) { instance_double("Storm", "storm") }
  let(:weather) { instance_double("Forecast::Weather", "weather", daily: day_weather) }
  let(:day_weather) { instance_double("Forecast::Weather", "day_weather", size: 4) }
  let(:timezone) { instance_double("DateTime", "timezone") }
  let(:days) { instance_double("Array", "days") }
  let(:day) { instance_double("DateTime", "day") }
  let(:day_in_word) { instance_double("DateTime", "day_in_word") }

  describe '#get_daily' do
    it 'returns the weekly weather' do
      allow(Weather).to receive(:new).and_return weather
      filtered_days = instance_double("Array", "filtered_days")
      allow(days).to receive_message_chain(:in_words, :[]) { filtered_days }
      result = subject.get_daily(days)
      expect(result["swellHeight"]).to be day_weather
    end
  end

  describe '#get_hourly' do 
  end
end
