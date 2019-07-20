require 'api/storm_glass' 

class Location < ApplicationRecord
  before_save :set_forecast
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
    set_job if forecast.nil?
    self.forecast = api.getWaveForecast
  end

  def set_job
    Sidekiq::Cron::Job.create(name: 'Location - update forecast data - every 24 hours', cron: '* 24 * *', class: 'LocationWorker', args: self.id ) 
  end

  def current_forecast
    forecast.select { |row| row["time"] == timeNow }.first if forecast.present?
  end

  def api 
    @api = StormGlass.new(latitude, longitude)
  end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end
end
