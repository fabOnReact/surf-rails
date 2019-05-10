class AddIndexOnLatitudeAndLongitude < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, [:latitude, :longitude]
    add_index :posts, [:latitude, :longitude]
  end
end
