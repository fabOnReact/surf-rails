require 'rails_helper'
require 'forecast'

describe Forecast do
  subject { Forecast.new([current_data, future_data]) } 
  let(:current_data) { double("row") }
  let(:current_time) { double("time") }
  let(:future_data) { double("row") }
  let(:future_time) { double("time") }
  let(:future_forecast) { Forecast.new([future_data]) }

  context 'timeNow is current_time double' do
    before do 
      allow(subject).to receive(:timeNow) { current_time }
      allow(future_data).to receive(:[]).with("time") { future_time }
      allow(current_data).to receive(:[]).with("time") { current_time }
    end

    describe '#current' do 
      it 'returns the current forecast' do
        expect(subject.current).to be current_data
      end
    end

    describe '#days' do 
      it 'returns the upcoming forecast timestamps' do 
        allow(subject).to receive(:upcoming) { [ future_data ] }
        expect(subject.days).to eql [ future_time ]
      end
    end
    describe '#upcoming' do
      it 'return the upcoming forecast' do
        expect(current_time).to receive(:>=).with(current_time) { false }
        expect(future_time).to receive(:>=).with(current_time) { true }
        expect(subject.upcoming).to eql future_forecast
      end
    end
  end
end
