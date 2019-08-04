require 'core_ext/array'

class Forecast < Array
  Array.include(Array::Weather)
  Hash.include(Hash::Weather)

  def decorator
    { hours: hours, days: days, waves: upcomingWavesAverage, tides: tides }
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

  def dailyAverage(key, day)
    within(day).collectForecast(key) {|x| x.values.average }[0..152]
  end

  def within(day)
    Forecast.new(select { |row| timeBegin >= row["time"] >= timeEnd })
  end

  def waveAverage; waveHeights.average; end
  def periodsAverage; swellPeriods.average; end

  def collectForecast(key)
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
