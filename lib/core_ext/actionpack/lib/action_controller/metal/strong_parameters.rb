module Parameters
  module Validations
    def location?
      self[:longitude].present? && self[:latitude].present?
    end

    def gps
      [self[:latitude], self[:longitude]]
    end
  end
end

