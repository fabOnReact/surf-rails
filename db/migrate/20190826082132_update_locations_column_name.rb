class UpdateLocationsColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :forecast, :weather
    rename_column :locations, :tide_chart, :weather_tide
    rename_column :locations, :daily, :weather_daily
    rename_column :locations, :hourly, :weather_hourly
  end
end
