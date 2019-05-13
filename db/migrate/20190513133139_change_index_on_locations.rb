class ChangeIndexOnLocations < ActiveRecord::Migration[5.1]
  def change
    remove_index :locations, [:country, :name]
  end
end
