require 'api/storm_glass'

class Location < ApplicationRecord
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  has_many :posts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo && geo.data["error"].nil?
      obj.address = geo.address
    end
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

