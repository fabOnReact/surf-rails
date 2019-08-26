require 'rails_helper'
RSpec.describe DailyForecastWorker, type: :worker do
  subject { DailyForecastWorker.new }
  let(:location) { instance_double("location") }
  let(:forecast) { instance_double("forecast") }
  let(:tide) { instance_double("tide") }
  before do 
    allow(Location).to receive(:find_by)
      .with({ id: 1, with_forecast: false })
      .and_return location 
  end

  describe '#data_available?' do
    it 'executes api call if current forecast is not available' do
      allow(location).to receive(:current_forecast?).and_return(false)
      expect(location).to receive_message_chain(:storm, :success?) { true }
      subject.send(:set_location, { "id" => 1 })
      expect(subject.data_available?).to be true
    end

    it 'does not execute an api call if current forecast is available' do
      allow(location).to receive(:current_forecast?).and_return(true)
      expect(location).to_not receive(:storm)
      subject.send(:set_location, { "id" => 1 })
      expect(subject.data_available?).to be true
    end
  end

  describe '#execute_job' do
    context 'current forecast available in db' do
      before do 
        allow(subject).to receive(:forecast?) { true }
        allow(location).to receive_message_chain(:forecast, :current) { forecast }
        allow(subject).to receive(:timezone?) { false }
        allow(subject).to receive(:set_timezone)
        subject.send(:set_location, { "id" => 1 })
      end
      
      it 'will update the with_forecast column' do
        expect(subject).to receive(:get_forecast)
        expect(subject).to receive(:update_data)
        expect(location).to receive(:update).with(with_forecast: true)
        subject.execute_job
      end
    end
  end
end

