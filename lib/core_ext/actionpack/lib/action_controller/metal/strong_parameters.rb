module Parameters
  module Location
    def location?
      self[:longitude].present? && self[:latitude].present?
    end

    def corners
      sw = [ self[:southWest][:latitude], self[:southWest][:longitude] ]
      ne = [ self[:northEast][:latitude], self[:northEast][:latitude] ]
      [sw, ne]
    end

    def gps
      [self[:latitude], self[:longitude]]
    end
  end
end

