require 'api/storm' 

class LocationWorker
  include Sidekiq::Worker

  def perform(*args)
    @location = Location.find(args.first["id"])
    if args.first["hourly"]
      @location = Location.find(args.first["id"])
      @location.update(hourly: @location.forecast.hourly)
    else
      @location.update(forecast: api.getWaveForecast, tide: api.getTide)
      daily = @location.forecast.daily("waveHeight", @location.timezone)
      @location.update(daily: daily)
    end
  end

  def api 
    @api = Storm.new(@location.latitude, @location.longitude)
  end
end
