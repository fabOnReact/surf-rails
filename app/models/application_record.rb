class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def valid_coordinates(obj)
    obj.latitude.present? &&
    obj.longitude.present? &&
    obj.latitude.is_a?(Float) &&
    obj.longitude.is_a?(Float)
  end
end
