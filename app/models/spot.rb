class Spot < ApplicationRecord
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo.data["error"].nil?
      obj.address = geo.address
      obj.city = geo.city if geo.city
    end
  end

end
