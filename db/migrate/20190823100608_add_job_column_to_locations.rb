class AddJobColumnToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :with_forecast, :boolean
    add_index :locations, :with_forecast
  end
end
