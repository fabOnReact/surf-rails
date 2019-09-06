Location.where.not(good_swell_direction: nil).each do |location|
  location.update(best_swell_direction: location.good_swell_direction.split(", "))
end

Location.where.not(good_wind_direction: nil).each do |location|
  location.update(best_wind_direction: location.good_wind_direction.split(", "))
end
