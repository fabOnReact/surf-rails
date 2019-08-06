require 'rails_helper'
require 'core_ext/array'

describe Array do
  Array.include(Array::Weather)
  let(:value_array1) do 
    [{"value"=>1.78, "source"=>"sg"}, {"value"=>2.0, "source"=>"icon"}]
  end

  let(:value_array2) do 
    [{"value"=>0.78, "source"=>"sg"}, {"value"=>2.0, "source"=>"icon"}]
  end

  # let(:waveHeight) { value_array1 + value_array2 }

  let(:forecast) do
    [
      {"waveHeight" => value_array1, "hour" => 1}, 
      {"waveHeight" => value_array2, "hour" => 2}
    ] 
  end 

  describe '#minMaxString' do 
    it 'removes duplicates' do
      expect(value_array1.minMaxString).to eql "2"
    end

    it 'returns a range of min and max' do
      expect(value_array2.minMaxString).to eql "1-2"
    end
  end
  describe '#average' do 
    it 'calculates the correct average' do
      heights = [1.9, 1.91, 1.9, 1.69]
      expect(heights.average).to eql 1.8
    end
  end
 
  describe "#collectValues" do
    it "returns the values in an array" do
      expect(value_array1.collectValues).to eql [1.78, 2.0]
    end
  end

  describe "#collectWaveHeight" do
    it "returns the averages in an array if block is given" do
      average = forecast.collectWaveHeights do |x| 
        x.collectValues.average
      end 
      expect(average).to eql [1.9, 1.4]
    end

    it "returns the waveHeights if no-block is given" do
      waveHeights = forecast.collectWaveHeights
      expect(waveHeights).to eql [value_array1, value_array2]
    end
  end
end
