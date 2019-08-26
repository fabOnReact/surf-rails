require 'api/storm' 
require 'core_ext/string'
require 'core_ext/hash'
require 'api/google'
require 'forecast'
require 'forecast/wave'

class Location < ApplicationRecord
  String.include(String::Weather)
  Hash.include(Hash::Weather)

  after_validation :reverse_geocode, if: ->(obj){ valid_coordinates(obj) }
  has_many :posts
  has_many :forecasts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def tide_data
    tides["extremes"][0..4]
  end

  def current_forecast?
    self.present? && self.forecast.current.present?
  end
  
  def valid_coordinates(obj)
    obj.latitude.present? and 
    obj.longitude.present? and
    obj.latitude.is_a? Float and
    obj.longitude.is_a? Float
  end

  def forecast
    Forecast::Wave.new(read_attribute(:forecast) || [])
  end

  def distance_from_user(user_gps)
    Geocoder::Calculations.distance_between(user_gps, gps, units: :km).round(1)
  end

  def gps; [latitude, longitude]; end

  def offsetHours
    timezone["rawOffset"] / 3600
  end

  def storm
    @storm ||= Storm.new(latitude, longitude)
  end

  def maps
    @maps ||= Google::Maps.new(gps.join(','))
  end

  def google_map
    gpsString = gps.join(',')
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gpsString}&zoom=11&markers=#{gpsString}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
  end

  def set_job
    Sidekiq::Cron::Job.load_from_array(
      [
        { 
          name: "Location name: #{self.name}, id: #{self.id} - update forecast data - every day at 00:00", 
          id: "Location name: #{self.name}, id: #{self.id} - update forecast data - every day at 00:00", 
          cron: "0 0 * * *",
          class: 'DailyForecastWorker',
          args: { id: id }
        },
        {
          name: "Location name: #{self.name}, id: #{self.id} - update hourly forecast data - every hour at 00:00",
          id: "Location name: #{self.name}, id: #{self.id} - update hourly forecast data - every hour at 00:00",
          cron: "0 * * * *",
          class: 'HourlyForecastWorker',
          args: { id: id }
        },
      ]
    )  
    DailyForecastWorker.perform_async({ id: self.id })
  end
end
