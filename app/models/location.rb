require 'api/storm_glass' 
require 'core_ext/array'

class Location < ApplicationRecord
  Array.include(Array::Forecast)
  before_save :set_forecast, if: Proc.new {|location| location.forecast.nil? }
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  has_many :posts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def forecastDecorator
    { tides: tides, dates: dates, tide: tide, waves: upcomingWavesAverage }
  end

  def distance_from_user(user_gps)
    Geocoder::Calculations.distance_between(user_gps, gps, units: :km).round(1)
  end

  def gps; [latitude, longitude]; end

  def set_forecast
    set_job
    assign_attributes({ forecast: api.getWaveForecast, tide: api.getTide })
  end

  def set_job
    Sidekiq::Cron::Job.load_from_array(jobs_params)
  end

  def tides
    upcoming_forecast.map {|x| x["seaLevel"].first["value"] }[0..24]
  end

  def dates
    upcoming_forecast.map {|x| x["time"] }[0..24]
  end

  def current_forecast
    forecast.select { |row| row["time"] == timeNow }.first if forecast.present?
  end

  def upcoming_forecast
    @upcoming_forecast = forecast.select { |row| row["time"] >= timeNow }
  end

  def upcomingWavesAverage
    upcoming_forecast.collectWaveHeights {|x| x.collectValues.average }[0..24]
  end
    
  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method(method) { current_forecast[method].minMaxString }
  end

  %w(swellHeight waveHeight windSpeed).each do |method|
    define_method(method) { current_forecast[method].first["value"] } 
  end

  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) { current_forecast[method].collect {|x| x["value"]}}
  end

  %w(windDirection waveDirection swellDirection).each do |method|
    define_method(method) { current_forecast[method].first["value"] }
  end

  def waveAverage; waveHeights.average; end
  def periodsAverage; swellPeriods.average; end

  def api 
    @api = StormGlass.new(latitude, longitude)
  end

  # def timeMorning
  #   DateTime.now.utc.in_time_zone(-1)
  # end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end

  def google_map
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gps.join(',')}&zoom=11&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
  end

  def jobs_params
    [{ name: "Location name: #{self.name}, country: #{self.country}, id: #{self.id} - update forecast data - every day at 00:00", cron: "0 0 * * *", class: 'LocationWorker', args: self.id }]
  end
end
