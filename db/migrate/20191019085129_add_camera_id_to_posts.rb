class AddCameraIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :camera_id, :integer
    add_index :posts, :camera_id
    remove_column :posts, :location_id, :integer
  end
end
