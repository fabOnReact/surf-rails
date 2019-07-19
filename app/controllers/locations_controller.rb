require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  skip_before_action :verify_authenticity_token

  def index
    @locations = Location.near(params.gps, 20, units: :km)
    @locations = Location.within_bounding_box(params.corners).paginate(page: params[:page], per_page: params[:per_page]) if params.corners?
    @locations = @locations.paginate(page: params[:page], per_page: params[:per_page])
    @locations.where(forecast: nil).each {|location| location.save }
  end
end
