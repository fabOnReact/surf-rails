class HourlyForecastWorker < DailyForecastWorker
  include Sidekiq::Worker

  def perform(args)
    set_location(args)
    current_forecast ? update_forecast : run_job
  end

  private
  def current_forecast
    @location.current_forecast?
  end

  def run_job
    DailyForecastWorker.perform_async({ "id" => @location.id })
  end

  def set_location(args)
    @location = Location.find_by(id: args["id"])
  end

  def update_forecast
    @location.update(forecast_hourly: @location.forecast.hourly)
  end
end
