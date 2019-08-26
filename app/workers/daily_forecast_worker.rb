require 'api/storm' 
require 'forecast'
require 'api/google'

class DailyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    set_location(args)
    execute_job if @location.present?
  end

  def execute_job
    update_forecast unless @location.current_forecast?
    set_timezone unless timezone?
    update_data if @location.storm.success?
  end

  private
  def set_location(args)
    @location = Location.find_by(id: args["id"], with_forecast: false)
  end

  def set_timezone
    @timezone ||= @location.maps.getTimezone
    @location.update(timezone: @timezone) 
  end

  def update_forecast
    @location.update({ 
      forecast: @location.storm.getWaves,
      tides: @location.storm.getTides,
    })
  end

  def timezone
    @location.timezone || @timezone
  end

  def update_data
    @location.update({ 
      forecast_tide: @location.forecast.tide,
      forecast_daily: @location.forecast.daily('waveHeight', timezone),
      forecast_hourly: @location.forecast.hourly,
      with_forecast: true,
    })
  end

  def timezone?
    @location.timezone.present?
  end
end
