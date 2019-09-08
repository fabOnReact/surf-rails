class DailyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    set_location(args)
    execute_job if @location.present?
  end

  def execute_job
    update_forecast unless @location.forecast.present?
    set_timezone unless timezone?
    update_data if @location.reload.forecast.available?
  end

  private
  def set_location(args)
    @location = Location.find_by(id: args["id"])
  end

  def set_timezone
    @timezone ||= @location.maps.getTimezone
    @location.update(timezone: @timezone) 
  end

  def update_forecast
    return unless @location.storm.success?
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
      forecast_daily: @location.get_daily_forecast,
      forecast_hourly: @location.forecast.hourly,
      with_forecast: true,
    })
  end

  def timezone?
    @location.timezone.present?
  end
end
