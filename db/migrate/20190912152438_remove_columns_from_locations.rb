class RemoveColumnsFromLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :forecast_tide, :jsonb
    remove_column :locations, :area, :string
    remove_column :locations, :country, :string
    remove_column :locations, :forecast_data, :jsonb
    remove_column :locations, :tides, :jsonb
    remove_column :locations, :forecast_daily, :jsonb
    remove_column :locations, :forecast_hourly, :jsonb
    remove_column :locations, :areas, :jsonb
  end
end
