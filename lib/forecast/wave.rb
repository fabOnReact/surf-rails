require 'forecast'

class Forecast::Wave < Forecast
  COORDINATES = {"North" => [340, 20], "NorthWest" => [300,340], "West" => [240, 280], "SouthWest" => [200, 240], "South" => [160, 200], "SouthEast" => [120, 160], "East" => [80, 120], "NorthEast" => [20, 60]}
  KEYS = %w(time swellHeight waveHeight windSpeed windDirection waveDirection swellDirection swellPeriod)

  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method("#{method}Range") { current[method].minMaxString }
  end

  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) { current[method].collect {|x| x["value"]}}
  end

  def available?
    current.present? && !!(waveHeight && swellPeriod && windDirection)
  end

  Wave::KEYS.each do |method|
    define_method(method) { current.value(method) } 
  end

  Wave::KEYS.each do |method|
    define_method("#{method}_at(time)".to_sym) do 
      select {|row| row["time"] == time }.first.value(method) 
    end
  end

  %w(windDirection waveDirection swellDirection).each do |method|
    define_method("#{method}InWord".to_sym) { in_word(send(method.to_sym)) } 
  end

  def in_word(input)
    case input
    when 0..30
      "North"
    when 30..60
      "NorthEast"
    when 60..120
      "East"
    when 120..150
      "SouthEast"
    when 150..210
      "South"
    when 210..240
      "SouthWest"
    when 240..300
      "West"
    when 300..330
      "NorthWest"
    when 330..360
      "North"
    end
  end

  def hourly
    Wave::KEYS.push("windDirectionInWord","swellDirectionInWord", "waveDirectionInWord").map {|key| [key, send(key.to_sym)] }.to_h
  end

  def within(day)
    Wave.new(select do |row| 
      datetime = row["time"].to_datetime
      dayBegin = day.beginning_of_day + 6.hours
      dayEnd = day.end_of_day - 6.hours
      (dayBegin..dayEnd).cover? datetime
    end)
  end

  def daily(key, timezone)
    return nil if available?
    days = (DateTime.now..DateTime.now+6).map {|day| day.in_time_zone(timezone["timeZoneId"]) }
    forecast = days.map {|day| dailyAverage(key, day)}.delete_if {|x| x.nil? } 
    days = days.map {|x| x.to_datetime.strftime("%A") }[0..forecast.size-1]
    { key => forecast, "days" => days }
  end

  def hourlyAverage(key, day)
    within(day).collectValues(key) do |x| 
      x.values.average 
    end
  end

  def dailyAverage(key, day)
    hourlyAverage(key, day).average
  end

  def upcomingWaves
    upcoming.collectValues('waveHeight') {|x| x.values.average }[0..152]
  end

  def waveHeightTotal
    total = forecast.sum {|h| h.value("waveHeight") }
  end

  def waveAverage; waveHeights.average; end

  def periodsAverage; swellPeriods.average; end

  def tide
    { hours: hours, seaLevels: seaLevels }
  end

  def seaLevels
    upcoming.map {|x| x.value("seaLevel") }[0..24]
  end

  def hours
    upcoming.map {|x| x["time"] }[0..24]
  end

  def time; 
    current["time"]; 
  end
end
