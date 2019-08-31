require 'rails_helper'
RSpec.describe DailyForecastWorker, type: :worker do
  subject { DailyForecastWorker.new }
  let(:location) { instance_double("location") }
  let(:forecast) { instance_double("forecast") }
  let(:tide) { instance_double("tide") }
  before do 
    allow(Location).to receive(:find_by)
      .with({ id: 1 })
      .and_return location 
  end

  describe '#perform' do
    after { subject.perform({ "id" => 1 }) }
    it 'will execute the job if a location is found' do
      expect(subject).to receive(:execute_job)
    end
  end

  describe '#execute_job' do
    context 'with available data' do
      before do 
        allow(location).to receive(:current_forecast?) { true }
        allow(location).to receive_message_chain(:timezone, :present?) { true }
        subject.send(:set_location, { "id" => 1 })
      end

      after { subject.execute_job }
      
      it 'will only recalculate current forecast with the existing data' do
        expect(subject).to_not receive(:update_forecast)
        expect(subject).to_not receive(:set_timezone)
        expect(location).to receive_message_chain(:storm, :success?) { true }
        expect(subject).to receive(:update_data)
      end
    end

    context 'without available data' do 
      before do 
        allow(location).to receive(:current_forecast?) { false }
        allow(subject).to receive(:timezone?) { false }
        subject.send(:set_location, { "id" => 1 })
      end

      after { subject.execute_job }
      
      it 'will only recalculate current forecast with the existing data' do
        expect(subject).to receive(:update_forecast)
        expect(subject).to receive(:set_timezone)
        expect(location).to receive_message_chain(:storm, :success?) { true }
        expect(subject).to receive(:update_data)
      end
    end 
  end
end

