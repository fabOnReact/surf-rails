class Forecast < ApplicationRecord
  String.include(String::Transformations)
  Hash.include(Hash::Permutations)
  Array.include(Array::Calculations)
  Float.include(Float::Coordinates)

  belongs_to :location
  KEYS = %w(swellHeight waveHeight windSpeed windDirection 
  waveDirection swellDirection swellPeriod)

  def weather
    Weather.new(read_attribute(:weather) || [])
  end

  # def get_swell_height(days) def get_wave_height(days) 
  # def get_wind_speed(days) def get_wind_direction(days) 
  # def get_wave_direction(days) def get_swell_direction(days) 
  # def get_swell_period(days)
  KEYS.each do |field|
    define_method("get_#{field.duckTyped}(days)") do |days|
      weather.daily(field, days)
    end
  end

  def get_daily(days)
    result ||= KEYS.map do |field|
      # send(:get_wind_speed(days), days)
      daily_forecast = send("get_#{field.duckTyped}(days)".to_sym, days)
      [field, daily_forecast]
    end
    size = result.first.second.size - 1
    result += [["days", days.in_words[0..size]]]
    result.to_h
  end

  def tide_data
    tides["extremes"][0..4]
  end

  def current_weather?
    self.present? && self.weather.current.present?
  end
end
