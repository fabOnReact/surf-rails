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
    it '#set_location if #valid_parameters' do
    end
  end

  describe '#set_location' do
    it 'returns the location instance' do
      expect(subject.send(:set_location, { "id" => 1 })).to be location 
    end
  end
end
