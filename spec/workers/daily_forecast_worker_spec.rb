require 'rails_helper'
RSpec.describe DailyForecastWorker, type: :worker do
  subject { DailyForecastWorker.new }
  let(:location) { instance_double("location") }
  let(:forecast) { instance_double("forecast") }
  let(:tide) { instance_double("tide") }
  let(:wave) { instance_double("wave") }
  before do 
    allow(Location).to receive(:find_by)
      .with({ id: 1 })
      .and_return location 
    allow(location).to receive_message_chain(:storm, :getWaves) { wave }
    allow(location).to receive_message_chain(:storm, :getTides) { tide }
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
        allow(subject).to receive(:current_forecast?) { true }
        allow(location).to receive_message_chain(:timezone, :present?) { true }
        subject.send(:set_location, { "id" => 1 })
      end

      after { subject.execute_job }
      
      it 'will only recalculate current forecast with the existing data' do
        expect(subject).to_not receive(:update_forecast)
        expect(subject).to_not receive(:set_timezone)
        expect(location).to_not receive(:storm)
        expect(subject).to receive(:update_data)
      end
    end

    context 'without available data' do 
      before do 
        allow(subject).to receive(:timezone?) { false }
        expect(subject).to receive(:set_timezone)
        subject.send(:set_location, { "id" => 1 })
      end

      after { subject.execute_job }
      
      it 'retrieves the forecast data via api and recalculates the forecast' do
        expect(subject).to receive(:current_forecast?).and_return(false, true)
        expect(location).to receive_message_chain(:storm, :success?) { true }
        expect(location).to receive(:update).with({
          forecast: wave,
          tides: tide
        }).and_return(true)
        expect(subject).to receive(:update_data)
      end 

      it 'does not update if the api calls fails' do
        expect(subject).to receive(:current_forecast?).and_return(false, false)
        expect(location).to receive_message_chain(:storm, :success?) { false }
        expect(location).to_not receive(:update)
        expect(subject).to_not receive(:update_data) 
      end
    end
  end
end

