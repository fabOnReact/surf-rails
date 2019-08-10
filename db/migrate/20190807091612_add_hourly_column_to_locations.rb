class AddHourlyColumnToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :hourly, :jsonb
  end
end
