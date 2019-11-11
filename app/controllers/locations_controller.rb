require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)
  def index
    set_locations_with_box if params.corners?
    set_locations_with_cameras if params[:with_cameras]
    set_nearby_locations if nearby_locations?
    respond_to do |format|
      format.html
      format.json do 
        decorate_locations
        render json: @locations, status: 200, location: locations_path 
      end
    end
  end
  
  private
  def nearby_locations?
    params.gps? && !params[:with_cameras]
  end

  def set_locations_with_box
    @locations = Location.within_bounding_box(params.corners)
      .limit(params[:limit])
  end

  def set_locations_with_cameras
    @locations = Location
      .with_posts
      .newest
      .newest_cameras
      .newest_posts
      .limit(20)
  end

  def set_nearby_locations
    distance = params[:distance] || 2
    @locations = Location.near(params.gps, distance, units: :km)
  end

  def options
    @options = { params: {}, include: {}}
    @options[:params][:gps] = params.gps if params.gps?
    add_include if params[:with_cameras]
    @options
  end

  def add_include
    @options[:include] = [:cameras, :posts]
    @options[:params][:with_cameras] = true 
  end

  def decorate_locations
    @locations = @locations.map do |location| 
      LocationSerializer.new(location, options)
        .serializable_hash # [:data][:attributes]
    end
  end
end
