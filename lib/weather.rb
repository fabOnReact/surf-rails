require 'core_ext/array'

class Weather < Array
  Array.include(Array::Calculations)
  Hash.include(Hash::Permutations)
  Float.include(Float::Coordinates)

  COORDINATES = { "North" => [340, 20], "NorthWest" => [300, 340], 
                  "West" => [240, 280], "SouthWest" => [200, 240],
                  "South" => [160, 200], "SouthEast" => [120, 160], 
                  "East" => [80, 120], "NorthEast" => [20, 60] }
  KEYS = %w(time swellHeight waveHeight windSpeed windDirection waveDirection 
  swellDirection swellPeriod)

  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method("#{method}Range") { current[method].minMaxString }
  end

  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) do 
      current[method].collect { |x| x["value"] } 
    end
  end

  %w(windDirection waveDirection swellDirection).each do |method|
    define_method("#{method}InWord".to_sym) { send(method.to_sym).in_word }
  end

  def tide_chart
    { hours: hours, seaLevels: seaLevels }
  end

  def seaLevels
    upcoming.map { |x| x.value("seaLevel") }[0..24]
  end

  def tideData
    upcoming.map { |x| [x.value("time"), x.value("seaLevel")] }.to_h
  end

  def hours
    upcoming.map { |x| x["time"] }[0..24]
  end

  def available?
    current.present? && !!(waveHeight && swellPeriod && windDirection)
  end

  KEYS.each do |method|
    define_method(method) { current.value(method) }
  end

  KEYS.each do |method|
    define_method("#{method}_at(time)".to_sym) do
      select { |row| row["time"] == time }.first.value(method)
    end
  end

  def current
    @current ||= select { |row| row["time"] == timeNow }.first
  end

  def timeNow
    DateTime.now
      .utc
      .in_time_zone()
      .beginning_of_hour
      .strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end

  def days
    upcoming.map { |x| x["time"] }[0..152]
  end

  def upcoming
    select { |row| row["time"] >= timeNow }
  end

  def select
    Weather.new(super)
  end

  def values
    collect { |x| x["value"] }
  end

  def collectValues(key)
    collect do |x|
      row = Weather.new(x[key])
      if block_given?; yield(row); else; row; end
    end
  end

  def hourly
    directions = [
      "windDirectionInWord", 
      "swellDirectionInWord", 
      "waveDirectionInWord"
    ]
    KEYS.push(*directions).map do |key|
      [key, send(key.to_sym)]
    end.to_h
  end

  def within(day)
    Weather.new(select do |row|
      datetime = row["time"].to_datetime
      dayBegin = day.beginning_of_day + 6.hours
      dayEnd = day.end_of_day - 6.hours
      (dayBegin..dayEnd).cover? datetime
    end)
  end

  def daily(key, week_days)
    return nil unless available?
    week_days.map { |day| dailyAverage(key, day) }.delete_if { |x| x.nil? }
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
    upcoming.collectValues('waveHeight') { |x| x.values.average }[0..152]
  end

  def waveHeightTotal
    forecast.sum { |h| h.value("waveHeight") }
  end

  def waveAverage; waveHeights.average; end

  def periodsAverage; swellPeriods.average; end
end
