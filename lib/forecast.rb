require 'core_ext/array'

class Forecast < Array
  Array.include(Array::Weather)
  Hash.include(Hash::Weather)

  def decorator
    { hours: hours, days: days, waves: upcomingWaves, tides: tides }
  end

  def upcomingWaves
    upcoming.collectValues('waveHeight') {|x| x.values.average }[0..152]
  end

  def current
    select {|row| row["time"] == timeNow }.first
  end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end

  def waveHeightTotal
    total = forecast.sum {|h| h.value("waveHeight") }
  end

  def tides
    upcoming.map {|x| x.value("seaLevel") }[0..24]
  end

  def hours
    upcoming.map {|x| x["time"] }[0..24]
  end

  def days
    upcoming.map {|x| x["time"] }[0..152]
  end

  def upcoming
    Forecast.new(select { |row| row["time"] >= timeNow })
  end

  def values
    collect {|x| x["value"] }
  end

  def hourlyAverage(key, day)
    within(day).collectValues(key) do |x| 
      x.values.average 
    end
  end

  def dailyAverage(key, day)
    hourlyAverage(key, day).average
  end

  def within(day)
    Forecast.new(select do |row| 
      datetime = row["time"].to_datetime
      dayBegin = day.beginning_of_day + 6.hours
      dayEnd = day.end_of_day - 6.hours
      (dayBegin..dayEnd).cover? datetime
    end)
  end

  def weeklyForecast(key, timezone)
    forecast = (DateTime.now..DateTime.now+6).map do |day| 
      day = day.in_time_zone(timezone)
      dailyAverage(key, day)
    end.delete_if {|x| x.nil? }
  end

  def waveAverage; waveHeights.average; end

  def periodsAverage; swellPeriods.average; end

  def collectValues(key)
    collect do |x| 
      row = Forecast.new(x[key])
      if block_given?; yield(row); else; row; end
    end
  end

  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method("#{method}Range") { current[method].minMaxString }
  end

  %w(swellHeight waveHeight windSpeed windDirection waveDirection swellDirection swellPeriod).each do |method|
    define_method(method) { current.value(method) } 
  end

  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) { current[method].collect {|x| x["value"]}}
  end
end
