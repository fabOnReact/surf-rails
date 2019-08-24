require 'rails_helper'
RSpec.describe DailyForecastWorker, type: :worker do
  let(:location) { FactoryBot.create(:location, latitude: -8.716364, longitude:115.166931 ) } 
  let(:hour) do 
    { 
      "swellHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "waveHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "seaLevel"=>[{"value"=>0.27, "source"=>"sg"}],
    }
  end
  let(:date1) { instance_double("date") } 
  let(:date2) { instance_double("date") } 
  let(:forecast) do 
    hour1, hour2 = hour
    hour1["time"] = date1 
    hour2["time"] = date2 
    Forecast.new([ hour1, hour2 ])
  end 

  describe '#perform' do
    it 'should update the forecast attribute of location' do
      LocationWorker.new.perform({ "ids" => location.id })
      expect(location.reload.forecast).not_to be nil
    end

    it 'should upate the other columns' do 
      LocationWorker.new.perform({ "ids" => location.id })
      expect(location.reload.daily).not_to be nil
      expect(location.reload.hourly).not_to be nil
    end

    it 'should trigger runtime error if api fails' do
      allow_any_instance_of(Storm).to receive(:weather).and_return({'errors'=> 'some error'})
      expect{LocationWorker.new.perform(location.id)}.to raise_error(TypeErrorr)
    end
  end
end
