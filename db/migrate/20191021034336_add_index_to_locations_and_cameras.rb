class AddIndexToLocationsAndCameras < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, :last_camera_at
    add_index :cameras, :last_post_at
  end
end
