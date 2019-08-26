class ChangeLocationsAllColumnFromWeatherToForecast < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :weather_tide, :forecast_tide
    rename_column :locations, :weather_daily, :forecast_daily
    rename_column :locations, :weather_hourly, :forecast_hourly
  end
end
