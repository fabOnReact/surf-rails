class StormGlass
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
    DateTime.now.utc.to_time + 11.hours
  end

  def timestamp
    endTime.to_datetime.to_s
  end

  def getWeather
    @weather ||= self.class.get("/weather/point", @options)
  end
end
