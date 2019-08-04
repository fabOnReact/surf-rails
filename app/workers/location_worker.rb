require 'api/storm' 

class LocationWorker
  include Sidekiq::Worker

  def perform(*args)
    @location = Location.find(args.first)
    @location.update(forecast: api.getWaveForecast, tide: api.getTide)
  end

  def api 
    @api = Storm.new(@location.latitude, @location.longitude)
  end
end
