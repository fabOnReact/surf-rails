require 'api/storm_glass' 

class LocationWorker
  include Sidekiq::Worker

  def perform(*args)
    @location = Location.find(args.first)
    @location.update_attribute(:forecast, api.getWaveForecast)
  end

  def api 
    @api = StormGlass.new(@location.latitude, @location.longitude)
  end
end
