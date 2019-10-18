class AddJsonForecastColumnsToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :forecast_tide, :jsonb
    add_column :locations, :forecast_daily, :jsonb
    add_column :locations, :forecast_hourly, :jsonb
  end
end
