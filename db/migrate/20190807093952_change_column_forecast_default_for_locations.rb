class ChangeColumnForecastDefaultForLocations < ActiveRecord::Migration[5.1]
  def change
    change_column :locations, :forecast, :jsonb, :default => nil
  end
end
