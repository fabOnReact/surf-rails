class AddIndexToLocations < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, [:country, :area, :name], unique: true
  end
end
