class Location < ApplicationRecord
  # after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    if geo.data["error"].nil?
      obj.address = geo.address
    end
  end
end
