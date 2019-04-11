require 'rails_helper'
require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

describe ActionController::Parameters do
  ActionController::Parameters.include(Parameters::Validations)
  describe 'with_location?' do
    it 'check that gps coordinates are present' do
      params1 = ActionController::Parameters.new({latitude: "", longitude: ""})
      params2 = ActionController::Parameters.new({latitude: "123", longitude: "456"})
      expect(params1.location?).to be false
      expect(params2.location?).to be true
    end
  end
end
