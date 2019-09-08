class Forecast < ApplicationRecord
  String.include(String::Weather)
  Hash.include(Hash::Weather)

  belongs_to :location
  KEYS = %w(swellHeight waveHeight windSpeed windDirection waveDirection swellDirection swellPeriod)

  def weather
    ::Weather.new(read_attribute(:weather) || [])
  end

  # def get_swell_height, get_wave_height, get_wind_speed, get_wind_direction, get_wave_direction, get_swell_direction, get_swell_period
  #   weather.daily("swellHeight", get_week_days)
  KEYS.each do |field|
    define_method("get_#{field.duckTyped}".to_sym) do
      weather.daily(field, get_week_days)
    end
  end

  def get_week_days
    @week_days ||= (DateTime.now..DateTime.now + 6).map do |day|
      day.in_time_zone(timezone["timeZoneId"])
    end
  end

  def get_week_days_in_word
    @week_days_in_work ||= get_week_days.map do |x|
      x.to_datetime.strftime("%A")
    end
  end

  def get_daily_weather
    result = ::KEYS.map do |field|
      # ["swellHeight", send(:get_swell_height)]
      [field, send("get_#{field.duckTyped}".to_sym)]
    end
    size = result.first.second.size - 1
    result += [["days", get_week_days_in_word[0..size]]]
    result.to_h
  end

  def tide_data
    tides["extremes"][0..4]
  end

  def current_weather?
    self.present? && self.weather.current.present?
  end

  def get_hourly_weather
    weather.hourly.merge(optimal_conditions)
  end

  def optimal_conditions
    { "optimal_swell" => optimal_swell?, "optimal_wind" => optimal_wind? }
  end

  %w(wind swell).each do |method|
    define_method("optimal_#{method}?".to_sym) do
      best_condition = send("best_#{method}_direction".to_sym)
      best_condition.include? weather.send("#{method}DirectionInWord".to_sym) if best_condition
    end
  end

  %w(wind swell).each do |field|
    define_method("optimal_#{field}?(#{field})".to_sym) do
      best_condition = send("best_#{field}_direction".to_sym)
      best_condition.include? field if best_condition
    end
  end

  def storm
    @storm ||= Storm.new(latitude, longitude)
  end

  def maps
    @maps ||= Google::Maps.new(gps.join(','))
  end
end
