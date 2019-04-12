require 'rails_helper'
require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

describe ActionController::Parameters do
  ActionController::Parameters.include(Parameters::Validations)
  let(:empty_coordinates) { ActionController::Parameters.new({latitude: "", longitude: ""}) }
  let(:coordinates) { ActionController::Parameters.new({latitude: "123", longitude: "456"}) }
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
end
