require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  skip_before_action :verify_authenticity_token

  def index
    return @locations = Location.near(params.gps, 20, units: :km) if params.location?
    @locations = Location.within_bounding_box(params.corners) 
  end
end
