require 'api/storm' 
require 'forecast'
require 'api/google'

class DailyForecastWorker
  include Sidekiq::Worker

  def perform(*args)
    @location = Location.find_by(id: args.first["id"], with_forecast: false)
    execute_job if valid_parameters?
  end

  def execute_job
    forecast ? get_forecast : set_forecast
    set_timezone unless timezone?
    update_forecast
    @location.update(with_forecast: true) if @location.reload.forecast.present?
  end

  private
  def set_timezone
    @location.update(timezone: @location.maps.getTimezone) 
  end

  def update_forecast
    @location.update({ 
      forecast: @forecast,
      tide: @location.storm.getTide,
      tide_chart: @forecast.tideChart,
      daily: @forecast.daily('waveHeight', @location.timezone),
      hourly: @forecast.hourly,
      meta: @forecast.meta,
    })

  def timezone?
    @location.timezone.nil?
  end

  def valid_parameters?
    @location && @location.storm.success?
  end

  def forecast 
    @location.forecast.current.nil?
  end

  def set_forecast
    @forecast = Forecast.new(@location.storm.getWaveForecast)
  end

  def get_forecast
    @forecast = @location.forecast
  end
end
