class RenameForecastsDataToWeather < ActiveRecord::Migration[5.1]
  def change
    rename_column :forecasts, :data, :weather
  end
end
