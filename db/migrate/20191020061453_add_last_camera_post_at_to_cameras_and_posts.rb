class AddLastCameraPostAtToCamerasAndPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :cameras, :last_post_at, :datetime
    add_column :locations, :last_camera_at, :datetime
  end
end
