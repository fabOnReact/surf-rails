class AddWithCamerasToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :with_cameras, :boolean, default: false
  end
end
