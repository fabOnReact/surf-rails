class HourlyForecastWorker
  include Sidekiq::Worker

  def perform(*args)
    location = Location.find_by(id: args.first["id"])
    location.update(hourly: location.forecast.hourly) if location && location.storm.quotaExceeded?
  end
end
