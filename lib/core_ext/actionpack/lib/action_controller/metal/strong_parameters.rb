module Parameters
  module Validations
    def location?
      self[:longitude].present? && self[:latitude].present?
    end

    def gps
      [self[:latitude], self[:longitude]]
      # request.location.latitude 
      # request.location.longitude
    end
  end
end

