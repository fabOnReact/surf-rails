require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  skip_before_action :verify_authenticity_token

  def index
    if params.corners?
      @locations = Location.within_bounding_box(params.corners) 
    elsif params.gps?
      @locations = Location.near(params.gps, 50, units: :km)
      @locations[0..8].select {|location| location.forecast.empty? }.each do |location|
        STDERR.puts "->>>>> Saving Location - location: #{location}, errors: #{location.errors.full_messages}"
        ActiveRecord::Base.logger.silence { location.save }
      end
      @locations = @locations.where.not(forecast: nil).limit(8)
    end
  end
end
