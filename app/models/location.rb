require 'api/storm' 
require 'api/google'
require 'core_ext/string'
require 'core_ext/hash'
require 'forecast'

class Location < ApplicationRecord
  String.include(String::Weather)
  Hash.include(Hash::Weather)

  before_save :set_forecast, if: Proc.new {|location| location.forecast.eql? [] }
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  has_many :posts
  has_many :forecasts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def forecast
    Forecast.new(read_attribute(:forecast) || [])
  end

  def upcomingTide
    tide["extremes"][0..4]
  end

  def distance_from_user(user_gps)
    Geocoder::Calculations.distance_between(user_gps, gps, units: :km).round(1)
  end

  def gps; [latitude, longitude]; end

  def set_forecast
    set_job
    self.tide = storm.getTide
    self.forecast = storm.getWaveForecast
    self.timezone = maps.getTimezone
    self.daily = forecast.daily("waveHeight", timezone)
    self.hourly = forecast.hourly
  end

  def offsetHours
    timezone["rawOffset"] / 3600
  end

  def set_job
    Sidekiq::Cron::Job.load_from_array(jobs_params) unless Rails.env.test?
  end

  def maps
    @maps = Google::Maps.new(gps.join(','))
  end

  def storm
    @storm = Storm.new(latitude, longitude)
  end

  def google_map
    gpsString = gps.join(',')
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gpsString}&zoom=11&markers=#{gpsString}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
  end

  def jobs_params
    [{ name: "Location name: #{self.name}, country: #{self.country}, id: #{self.id} - update forecast data - every day at 00:00", cron: "0 0 * * *", class: 'LocationWorker', args: {id: self.id, hourly: false}}, { name: "Location name: #{self.name}, country: #{self.country}, id: #{self.id} - update hourly forecast data - every hour at 00:00", cron: "0 * * * *", class: 'LocationWorker', args: { id: self.id, hourly: true}}]
  end
end
