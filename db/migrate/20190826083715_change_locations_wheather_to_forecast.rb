class ChangeLocationsWheatherToForecast < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :weather, :forecast
  end
end
