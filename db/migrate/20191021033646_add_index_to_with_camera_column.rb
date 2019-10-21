class AddIndexToWithCameraColumn < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, :with_cameras
  end
end
