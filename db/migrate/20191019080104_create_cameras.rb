class CreateCameras < ActiveRecord::Migration[5.1]
  def change
    create_table :cameras do |t|
      t.integer :location_id
      t.float :latitude
      t.float :longitude
      t.integer :rating

      t.timestamps
    end

    add_index :cameras, :location_id
    add_index :cameras, :latitude
    add_index :cameras, :longitude
  end
end
