class AddForecastMetaToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :meta, :jsonb
  end
end
