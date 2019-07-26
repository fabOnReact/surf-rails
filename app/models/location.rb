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
    self.forecast = api.getWaveForecast 
  end

  def set_job
    job = Sidekiq::Cron::Job.new(name: "Location name: #{self.name}, country: #{self.country}, id: #{self.id} - update forecast data - every day at 00:00", cron: "0 0 * * *", class: 'LocationWorker', args: self.id)
    puts job.errors unless job.save
  end

 def tide
   upcoming_forecast.map {|x| x["seaLevel"].first["value"] }
 end

 def tideDates
   upcoming_forecast.map {|x| x["time"] }
 end

  def current_forecast
    forecast.select { |row| row["time"] == timeNow }.first if forecast.present?
  end

  def upcoming_forecast
    @upcoming_forecast = forecast.select { |row| row["time"] >= timeNow }
  end

  def waveHeight
    current_forecast["waveHeight"].minMaxString
  end

  def windDirection
    current_forecast["windDirection"].first["value"]
  end

  def waveDirection
    current_forecast["waveDirection"].first["value"]
  end
  
  def windSpeed
    current_forecast["windSpeed"].minMaxString
  end

  def api 
    @api = StormGlass.new(latitude, longitude)
  end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end

  def google_map
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gps.join(',')}&zoom=11&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
  end
end
