require 'api/storm' 
require 'forecast'
require 'api/google'

class LocationWorker
  include Sidekiq::Worker

  def perform(*args)
    locations = Location.near(args.first["gps"], 30, units: :km).where(with_forecast: false).limit(8)
    locations.each do |location|
      forecast = Forecast.new(location.storm.getWaveForecast)
      location.update(timezone: location.maps.getTimezone) if location.timezone.nil?
      location.update({ 
        forecast: forecast,
        tide: location.storm.getTide,
        daily: forecast.daily('waveHeight', location.timezone),
        hourly: forecast.hourly,
      })
      location.update(with_forecast: true) if location.reload.forecast.present?
    end
  end
end
