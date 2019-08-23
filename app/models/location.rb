require 'api/storm' 
require 'core_ext/string'
require 'core_ext/hash'
require 'api/google'
require 'forecast'

class Location < ApplicationRecord
  String.include(String::Weather)
  Hash.include(Hash::Weather)

  # before_save :set_forecast, if: Proc.new {|location| location.forecast.eql? [] }
  after_validation :reverse_geocode, if: ->(obj){ valid_coordinates(obj) }
  has_many :posts
  has_many :forecasts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
  end

  def valid_coordinates(obj)
    obj.latitude.present? and 
    obj.longitude.present? and
    obj.latitude.is_a? Float and
    obj.longitude.is_a? Float
  end

  def forecast
    Forecast.new(read_attribute(:forecast) || [])
  end

  def tideData
    tide["extremes"][0..4]
  end

  def distance_from_user(user_gps)
    Geocoder::Calculations.distance_between(user_gps, gps, units: :km).round(1)
  end

  def gps; [latitude, longitude]; end

  def offsetHours
    timezone["rawOffset"] / 3600
  end

  def set_job
  end

  def storm
    @storm = Storm.new(latitude, longitude)
  end

  def maps
    @maps = Google::Maps.new(gps.join(','))
  end

  def google_map
    gpsString = gps.join(',')
    "https://maps.googleapis.com/maps/api/staticmap?center=#{gpsString}&zoom=11&markers=#{gpsString}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
  end
end
