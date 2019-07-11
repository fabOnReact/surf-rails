class StormGlass
  include HTTParty
  FIELDS = %w(swellHeight swellPeriod swellDirection waveHeight wavePeriod waveDirection windDirection windSpeed seaLevel)
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
    DateTime.now.utc.to_time + 24.hours
  end

  def timestamp
    endTime.to_datetime.to_s
  end

  def getWeather
    @weather ||= self.class.get("/weather/point", @options)
  end
  
  def getWaveForecast 
    getWeather["hours"].map do |row|
      row.keep_if {|key, value| FIELDS.include? key }
    end
  end
end
