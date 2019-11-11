class DailyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    set_location(args)
    execute_job if @location.present?
  end

  def execute_job
    update_or_create_forecast unless @location.forecast.present?
    set_timezone unless timezone?
    update_data if @location.reload.forecast.weather.available?
  end

  private
  def set_location(args)
    @location = Location.find_by(id: args["id"])
  end

  def set_timezone
    @timezone ||= @location.maps.getTimezone
    @location.update(timezone: @timezone) 
  end

  def update_or_create_forecast
    return unless @location.storm.success?
    @params = {
        weather: @location.storm.getWaves,
        tides: @location.storm.getTides,
    }
    @location.forecast ? update_forecast : create_forecast 
  end

  def update_forecast
    @location.forecast.update(@params)
  end

  def create_forecast
    @location.create_forecast(@params)
  end

  def timezone
    @location.timezone || @timezone
  end

  def update_data
    @location.update({
      forecast_tide_chart: @location.forecast.weather.tide_chart,
      forecast_daily: @location.get_daily,
      forecast_hourly: @location.get_hourly,
    })
  end

  def timezone?
    @location.timezone.present?
  end
end
