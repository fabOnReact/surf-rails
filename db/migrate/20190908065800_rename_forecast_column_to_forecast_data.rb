class RenameForecastColumnToForecastData < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :forecast, :forecast_data
  end
end
