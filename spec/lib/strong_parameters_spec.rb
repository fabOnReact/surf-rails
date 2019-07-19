require 'rails_helper'
require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

describe ActionController::Parameters do
  ActionController::Parameters.include(Parameters::Location)
  let(:empty_coordinates) { ActionController::Parameters.new({latitude: "", longitude: ""}) }
  let(:coordinates) { ActionController::Parameters.new({latitude: "123", longitude: "456"}) }
  let(:pagination) { ActionController::Parameters.new({per_page: 2, page: 1}) }

  let(:corners) do 
    ActionController::Parameters.new(
      { 
        southWest: { latitude: 10, longitude: 5 },
        northEast: { latitude: 5, longitude: 15 }
      } 
    )
  end

  describe '#with_location?' do
    it 'check that gps coordinates are present' do
      expect(empty_coordinates.location?).to be false
      expect(coordinates.location?).to be true
    end
  end

  describe '#gps' do 
    it 'returns an array with latitude and longitude' do
      expect(coordinates.gps).to eql ['123', '456']
    end
  end

  describe '#corners?' do
    it 'returns true if params are present' do 
      expect(corners.corners?).to be true
    end

    it 'returns true if params are present' do 
      expect(coordinates.corners?).to be false
    end
  end
end
