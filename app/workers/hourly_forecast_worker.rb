class HourlyForecastWorker < DailyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    set_location(args)
    update_forecast if @location.storm.success?
  end

  private
  def set_location(args)
    @location = Location.find_by(id: args["id"])
  end

  def update_forecast
    @location.update(forecast_hourly: @location.forecast.hourly)
  end
end
