module Parameters
  module Validations
    def location?
      self[:longitude].present? && self[:latitude].present?
    end
  end
end

