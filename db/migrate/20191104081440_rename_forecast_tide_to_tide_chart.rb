class RenameForecastTideToTideChart < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :forecast_tide, :forecast_tide_chart
  end
end
