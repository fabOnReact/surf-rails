class AddWeeklyForecastToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :daily, :jsonb
  end
end
