class ApiError
  def initialize(errors)
    @errors = errors
  end

  def method_missing(*args, &block)
    STDERR.puts "->>>>> API ERROR - Api Call failed with the following error #{@errors}"
  end
end

class StormGlass
  include HTTParty
  FIELDS = %w(time swellHeight swellPeriod swellDirection waveHeight wavePeriod waveDirection windDirection windSpeed seaLevel)
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

  def weather
    self.class.get("/weather/point", @options)
  end

  def errors; weather['errors']; end

  def getWeather
    weather["hours"] || ApiError.new(errors)
  end

  def getWaveForecast
    getWeather.map do |row|
      row.keep_if {|key, value| FIELDS.include? key }
    end
  end
end
