require 'api/storm' 
require 'forecast'
require 'api/google'

class DailyForecastWorker
  include Sidekiq::Worker

  def perform(*args)
    location = Location.find_by(id: args.first["id"], with_forecast: false)
    if location.present?
      forecast = Forecast.new(location.storm.getWaveForecast)
      location.update(timezone: location.maps.getTimezone) if location.timezone.nil?
      location.update({ 
        forecast: forecast,
        tide: location.storm.getTide,
        tide_chart: forecast.tideChart,
        daily: forecast.daily('waveHeight', location.timezone),
        hourly: forecast.hourly,
      })
      location.update(with_forecast: true) if location.reload.forecast.present?
    end
  end
end
