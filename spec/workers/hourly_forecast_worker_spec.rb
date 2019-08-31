require 'rails_helper'
RSpec.describe HourlyForecastWorker, type: :worker do
  subject { HourlyForecastWorker.new }
  let(:location) { instance_double("location") }

  before do 
    allow(Location).to receive(:find_by)
      .with({ id: 1 })
      .and_return location 
  end

  describe '#perform' do 
    after { subject.perform({ "id" => 1 }) }

    it 'calls #update_forecast if current forecasts are available in the db' do
      expect(location).to receive(:current_forecast?) { true }
      expect(subject).to receive(:update_forecast)
    end

    context "with no current forecast data in database" do
      before do 
        expect(location).to receive(:current_forecast?) { false }
        allow(location).to receive(:id) { 1 }
        expect(DailyForecastWorker).to receive(:perform_async).with({ "id" => 1 })
      end

      it 'does not trigger any api call' do
        expect(location).to_not receive(:storm)
      end

      it 'does not call #update_forecast' do
        expect(subject).to_not receive(:update_forecast)
      end
    end
  end

  describe '#set_location' do
    it 'returns the location instance' do
      expect(subject.send(:set_location, { "id" => 1 })).to be location 
    end
  end
end
