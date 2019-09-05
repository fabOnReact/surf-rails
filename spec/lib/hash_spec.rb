require 'rails_helper'
require 'core_ext/hash'

describe Hash do
  Hash.include(Hash::Weather)
  let(:forecast) do 
    {
      "time"=>"2019-07-29T04:00:00+00:00",
      "seaLevel"=>[{"value"=>0.47, "source"=>"sg" }],
      "waveHeight"=>[
        {"value"=>1.84, "source"=>"sg"}, 
        {"value"=>1.97, "source"=>"icon"}, 
        {"value"=>1.84, "source"=>"meteo"}, 
        {"value"=>1.8, "source"=>"noaa"}
      ],
       "wavePeriod"=>[
        {"value"=>5.74, "source"=>"sg"}, 
        {"value"=>5.74, "source"=>"meteo"}, 
        {"value"=>19.19, "source"=>"noaa"}
      ],
    }
  end

  describe '#keepKeys' do
    it 'filters the keys' do
      expect(forecast.keepKeys).to be forecast
    end
  end

  describe '#forecast_attributes' do
    it 'replaces the keys with duck_tiped strings' do
      expect(forecast.forecast_attributes).to eql({:sea_level=>0.47, :time=>"2019-07-29T04:00:00+00:00", :wave_height=>1.84, :wave_period=>5.74})
    end
  end
  describe '#value' do
    it 'returns nil if there are no values' do
      hash = Hash.new
      expect(hash).to receive(:get_values).with("waveHeight") { [] }
      waveHeight = hash.value("waveHeight")
      expect(waveHeight).to be nil
    end

    it 'returns the value' do 
      expect(forecast.value("waveHeight")).to eql 1.84
    end
  end
end
