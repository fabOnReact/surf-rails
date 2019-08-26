require 'core_ext/hash'
require 'forecast/wave'

class ApiError
  def initialize(errors)
    @errors = errors
  end

  def method_missing(*args, &block)
    puts "\n->>>>> API ERROR - Api Call failed with the following error #{@errors} \n" unless Rails.env.test?
    puts "\n"
  end
end

class Storm
  Hash.include(Hash::Weather)
  include HTTParty
  base_uri "https://api.stormglass.io/v1"

  def initialize(latitude, longitude) 
    @options = { 
      headers: { 'Authorization': ENV['STORM_API_KEY'] }, 
      query: { lat: latitude, lng: longitude, start: startTime, end: timestamp } 
    }
  end

  def startTime
    DateTime.now.utc.to_s
  end

  def endTime
    DateTime.now.utc.to_time + 5.days
  end

  def timestamp
    endTime.to_datetime.to_s
  end

  def weather
    @weather ||= self.class.get("/weather/point", @options)
  end

  def success?
    weather["errors"].nil?
  end

  def getWeather
    weather || ApiError.new(@weather["errors"])
  end
  
  def meta
    weather["meta"]
  end

  def getTides
    self.class.get("/tide/extremes/point", @options)
  end

  def getWaves
    getWeather["hours"].map {|row| row.keepKeys }
  end
end
