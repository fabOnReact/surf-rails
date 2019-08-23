require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class LocationsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  skip_before_action :verify_authenticity_token

  def index
    set_locations_with_box if params.corners?
    set_locations if params.gps?
  end

  def set_locations
    @locations = Location.near(params.gps, 30, units: :km).where(with_forecast: true).limit(8)
    set_job
  end

  def set_locations_with_box
    @locations = Location.within_bounding_box(params.corners)
      .limit(params[:limit])
  end

  def set_job
    Sidekiq::Cron::Job.load_from_array(job_params)
    LocationWorker.perform_async({ gps: params.gps })
  end

  def job_params
    [{ 
      name: "Updating locations 30km from #{params.gps}", 
      id: "Updating locations 30km from #{params.gps}", 
      cron: "0 0 * * *",
      class: 'LocationWorker',
      args: { gps: params.gps }
    }]
  end
end
