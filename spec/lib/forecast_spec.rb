require 'rails_helper'
require 'forecast'

describe Forecast do
  let(:timeNow) { rand(0..1) }
  let(:hour1) do 
    { 
      "time"=> 1, 
      "swellHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "waveHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "seaLevel"=>[{"value"=>0.27, "source"=>"sg"}],
    }
  end

  let(:hour2) do 
    { 
      "time"=> 2, 
      "swellHeight"=> [{ "value" => 3}, { "value" => 4 }],
      "waveHeight"=> [{ "value" => 3}, { "value" => 5 }], 
      "seaLevel"=>[{"value"=>1, "source"=>"sg"}],
    }
  end

  let(:forecast) { Forecast.new([ hour1, hour2 ]) }

  describe "#current" do
    it "filters the current forecasts" do
      allow(forecast).to receive(:timeNow).and_return(timeNow+1)
      expect(forecast.current).to eql forecast[timeNow]
    end
  end

  describe "#swellHeight" do 
    it "retrieve the swellHeight average" do
      allow(forecast).to receive(:timeNow).and_return(timeNow+1)
      expect(forecast.swellHeight).to eql forecast[timeNow]["swellHeight"].first["value"]
    end
  end

  describe "#swellHeightRange" do 
    it "retrieve the swellHeight average" do
      allow(forecast).to receive(:timeNow).and_return 1
      expect(forecast.swellHeightRange).to eql "1-2"
    end
  end

  describe "#waveHeights" do 
    it "retrieve the swellHeight average" do
      allow(forecast).to receive(:timeNow).and_return 1
      expect(forecast.waveHeights).to eql [1,2]
    end
  end

  describe "#upcoming" do
    it "filters the forecast by the hour" do
      allow(forecast).to receive(:timeNow).and_return(timeNow+1)
      expect(forecast.upcoming).to eql forecast[timeNow..2]
    end
  end

  describe "#tides" do
    it "collects the forecast tide hourly values" do
      allow(forecast).to receive(:timeNow).and_return 1
      expect(forecast.tides).to eql [0.27, 1]
    end
  end

  describe "#hours" do
    it "filters the hours of the first 24 entries" do 
      allow(forecast).to receive(:timeNow).and_return 1
      expect(forecast.hours).to eql [1,2]
    end
  end
end
