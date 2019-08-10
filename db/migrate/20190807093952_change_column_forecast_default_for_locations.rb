class ChangeColumnForecastDefaultForLocations < ActiveRecord::Migration[5.1]
  def up
    change_column :locations, :forecast, :jsonb, :default => nil
  end
  def down
    change_column :locations, :forecast, :jsonb, :default => []
  end
end
