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

    def corners?
      keys.to_set.superset? Set['southWest', 'northEast']
    end

    def gps
      [self[:latitude], self[:longitude]]
    end

    def gps?
      self[:latitude].present? && self[:longitude].present?
    end
  end
end

