module Hash::Weather
  FIELDS = { time: :time, swellHeight: :swell_height, swellPeriod: :swell_period, swellDirection: :swell_direction, waveHeight: :wave_height, wavePeriod: :wave_period, waveDirection: :wave_direction, windDirection: :wind_direction, windSpeed: :wind_speed, seaLevel: :sea_level }
  def keepKeys
    keep_if {|key, value| FIELDS.keys.include? key.to_sym }
  end

  def forecast_attributes
    keepKeys.map do |key, value| 
      new_value = key == "time" ? value : value.first["value"]
      result = [FIELDS[key.to_sym], new_value] 
    end.to_h
  end

  def value(m)
    fetch(m.to_s).first["value"]
  end
end
