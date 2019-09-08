require 'core_ext/array'

class Forecast::Weather < Array
  Array.include(Array::Weather)
  Hash.include(Hash::Weather)

  COORDINATES = { "North" => [340, 20], "NorthWest" => [300, 340], "West" => [240, 280], "SouthWest" => [200, 240], "South" => [160, 200], "SouthEast" => [120, 160], "East" => [80, 120], "NorthEast" => [20, 60] }
  KEYS = %w(time swellHeight waveHeight windSpeed windDirection waveDirection swellDirection swellPeriod)

  %w(swellHeight waveHeight windSpeed swellPeriod).each do |method|
    define_method("#{method}Range") { current[method].minMaxString }
  end

  %w(waveHeight swellPeriod).each do |method|
    define_method(method.pluralize) { current[method].collect { |x| x["value"] } }
  end

  %w(windDirection waveDirection swellDirection).each do |method|
    define_method("#{method}InWord".to_sym) { in_word(send(method.to_sym)) }
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
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end

  def days
    upcoming.map { |x| x["time"] }[0..152]
  end

  def upcoming
    select { |row| row["time"] >= timeNow }
  end

  def select
    Forecast::Data.new(super)
  end

  def values
    collect { |x| x["value"] }
  end

  def collectValues(key)
    collect do |x|
      row = Forecast::Data.new(x[key])
      if block_given?; yield(row); else; row; end
    end
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
    KEYS.push("windDirectionInWord", "swellDirectionInWord", "waveDirectionInWord").map do |key|
      [key, send(key.to_sym)]
    end.to_h
  end

  def within(day)
    Forecast::Data.new(select do |row|
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

  def tide
    { hours: hours, seaLevels: seaLevels }
  end

  def seaLevels
    upcoming.map { |x| x.value("seaLevel") }[0..24]
  end

  def hours
    upcoming.map { |x| x["time"] }[0..24]
  end
end
