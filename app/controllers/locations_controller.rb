require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  skip_before_action :verify_authenticity_token

  def index
    if params.corners?
      @locations = Location.within_bounding_box(params.corners) 
    elsif params.gps?
      @locations = Location.near(params.gps, 20, units: :km).paginate(page: params[:page], per_page: params[:per_page]) 
      @locations.where(forecast: nil).each {|location| location.save }
    end
  end
end
