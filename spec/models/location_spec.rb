require 'rails_helper'
require 'api/storm'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.build(:location, latitude: 1, longitude: 1) }
  let(:storm) { instance_double("storm") }
  let(:forecast) { instance_double("forecast") }

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
end
