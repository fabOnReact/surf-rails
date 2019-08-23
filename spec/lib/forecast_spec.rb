require 'rails_helper'
require 'forecast'

describe Forecast do
  let(:dateTimes) do
    ["2019-08-05T07:00:00+00:00", "2019-08-05T08:00:00+00:00", "2019-08-06T06:00:00+00:00"]
  end
  let(:random) { rand(0..2) }
  let(:timeNow) { dateTimes[random] } 
  let(:hour1) do 
    { 
      "time"=> dateTimes.first, 
      "swellHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "waveHeight"=> [{ "value" => 1}, { "value" => 2 }], 
      "seaLevel"=>[{"value"=>0.27, "source"=>"sg"}],
    }
  end

  let(:hour2) do 
    { 
      "time"=> dateTimes.second, 
      "swellHeight"=> [{ "value" => 3}, { "value" => 4 }],
      "waveHeight"=> [{ "value" => 3}, { "value" => 5 }], 
      "seaLevel"=>[{"value"=>1, "source"=>"sg"}],
    }
  end

  let(:hour3) do 
    { 
      "time"=> dateTimes.third, 
      "swellHeight"=> [{ "value" => 3}, { "value" => 4 }],
      "waveHeight"=> [{ "value" => 3}, { "value" => 5 }], 
      "seaLevel"=>[{"value"=>1, "source"=>"sg"}],
    }
  end

  let(:forecast) { Forecast.new([ hour1, hour2, hour3 ]) }

  context "random time" do
    before { allow(forecast).to receive(:timeNow).and_return(timeNow) }
    let(:first_day) { dateTimes.first.to_datetime }
    let(:second_day) { dateTimes.third.to_datetime }

    describe "#current" do
      it "filters the current forecasts" do
        expect(forecast.current).to eql forecast[random]
      end
    end

    describe "#swellHeight" do 
      it "retrieve the swellHeight average" do
        expect(forecast.swellHeight).to eql forecast[random]["swellHeight"].first["value"]
      end
    end

    describe "#upcoming" do
      it "filters the forecast by the hour" do
        expect(forecast.upcoming).to eql forecast[random..2]
      end
    end

    describe "#hourlyAverage" do
      it "returns an array with the hourly average" do
        expect(forecast.hourlyAverage("waveHeight", first_day)).to eql [1.5, 4.0]
        expect(forecast.hourlyAverage("waveHeight", second_day)).to eql [4.0]
      end

      it "returns empty array if no value is found" do
        date = dateTimes.last.to_datetime.in_time_zone("Asia/Makassar").to_datetime + 1.day
        expect(forecast.hourlyAverage("waveHeight", date)).to eql []
      end
    end

    describe "#dailyAverage" do
      it "returns the daily average" do
        expect(forecast.dailyAverage("waveHeight", first_day)).to eql 2.8
      end
    end

    describe "#within" do 
      it "filters forecast based on the day" do
        date1 = dateTimes.first.to_datetime.in_time_zone("Asia/Makassar").to_datetime
        date2 = dateTimes.last.to_datetime.in_time_zone("Asia/Makassar").to_datetime
        expect(forecast.within(date1)).to eql [forecast.first, forecast.second]
        expect(forecast.within(date2).last).to eql  forecast.last
      end
    end

    describe "#daily" do
      it "returns the array of weekly averages for the parameter" do
        today = dateTimes.first.to_datetime.utc.to_datetime
        allow(DateTime).to receive(:now).and_return(today)
        result = forecast.daily("waveHeight", "Asia/Makassar")
        expect(result).to eql({"days"=>["Monday", "Tuesday"], "waveHeight"=>[2.8, 4.0]})
      end
    end

    describe "#collectValues" do
      it "returns the values for that key" do
        expect(forecast.collectValues("swellHeight")).to eql([[{"value"=>1}, {"value"=>2}], [{"value"=>3}, {"value"=>4}], [{"value"=>3}, {"value"=>4}]])
      end

      it "executes the block and returns the average of each hour" do
        average = forecast.collectValues("swellHeight") {|x| x.values.average }
        expect(average).to eql [1.5, 3.5, 3.5]
      end
    end
  end
  describe "#at_(time)" do
    it "returns the forecast at a certain time" do
      expect(forecast.at(timeNow)).to be nil
    end
  end

  context "at time 1" do
    before { allow(forecast).to receive(:timeNow).and_return dateTimes.first }
    describe "#swellHeightRange" do 
      it "retrieve the swellHeight average" do
        expect(forecast.swellHeightRange).to eql "1-2"
      end
    end

    describe "#waveHeights" do 
      it "retrieve the swellHeight average" do
        expect(forecast.waveHeights).to eql [1,2]
      end
    end

    describe "#hours" do
      it "filters the hours of the first 24 entries" do 
        expect(forecast.hours).to eql(["2019-08-05T07:00:00+00:00", "2019-08-05T08:00:00+00:00", "2019-08-06T06:00:00+00:00"])
      end
    end

    describe "#upcomingWaves" do 
      it "returns an array of waves average heights for each hour" do
        expect(forecast.upcomingWaves).to eql [1.5, 4.0, 4.0]
      end
    end
  end
end
