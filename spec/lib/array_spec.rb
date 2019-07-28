require 'rails_helper'
require 'core_ext/array'

describe Array do
  Array.include(Array::Forecast)
  let(:current_forecast1) do 
    [{"value"=>1.78, "source"=>"sg"}, {"value"=>2.0, "source"=>"icon"}]
  end

  let(:current_forecast2) do 
    [{"value"=>0.78, "source"=>"sg"}, {"value"=>2.0, "source"=>"icon"}]
  end

  describe '#minMaxString' do 
    it 'removes duplicates' do
      expect(current_forecast1.minMaxString).to eql "2"
    end

    it 'returns a range of min and max' do
      expect(current_forecast2.minMaxString).to eql "1-2"
    end
  end
end
