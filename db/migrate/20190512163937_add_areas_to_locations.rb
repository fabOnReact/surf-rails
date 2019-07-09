class AddAreasToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :areas, :jsonb, null: false, default: '{}'
    add_index :locations, :areas, using: :gin
  end
end
