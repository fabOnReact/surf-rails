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

  def tideHighs
    tide["extremes"].select {|row| row["type"] == "high" }
  end

  def tideLows
    tide["extremes"].select {|row| row["type"] == "high" }
  end

  def tides
    upcoming_forecast.map {|x| x["seaLevel"].first["value"] }[0..24]
  end

  def tidesDates
    upcoming_forecast.map {|x| x["time"] }[0..24]
  end

  def current_forecast
    forecast.select { |row| row["time"] == timeNow }.first if forecast.present?
  end

  def upcoming_forecast
    @upcoming_forecast = forecast.select { |row| row["time"] >= timeNow }
  end

  def swellHeight
    current_forecast["swellHeight"].minMaxString
  end

  def waveHeight
    current_forecast["waveHeight"].minMaxString
  end

  def waveHeights
    current_forecast["waveHeight"].collect {|x| x["value"] }
  end

  def waveAverage
    sum = waveHeights.inject { |sum, el| sum + el }.to_f 
    (sum / waveHeights.size).round(1)
  end

  def windSpeed
    current_forecast["windSpeed"].minMaxString
  end

  def swellDirection
    current_forecast["swellDirection"].first["value"]
  end

  def waveDirection
    current_forecast["waveDirection"].first["value"]
  end

  def windDirection
    current_forecast["windDirection"].first["value"]
  end

  def swellPeriod
    current_forecast["swellPeriod"].minMaxString
  end

  def swellPeriods
    current_forecast["swellPeriod"].collect {|x| x["value"] }
  end

  def periodsAverage
    sum = swellPeriods.inject { |sum, el| sum + el }.to_f 
    (sum / swellPeriods.size).round()
  end

  def api 
    @api = StormGlass.new(latitude, longitude)
  end

  def timeMorning
    DateTime.now.utc.in_time_zone(-1)
  end

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
