class AddUniqueIndexOnForecastLocationId < ActiveRecord::Migration[5.1]
  def change
    remove_index :forecasts, :location_id
    add_index :forecasts, :location_id, unique: true
  end
end
