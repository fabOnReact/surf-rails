class AddColumnsToForecast < ActiveRecord::Migration[5.1]
  def change
    add_column :forecasts, :data, :jsonb
    add_column :forecasts, :location_id, :integer
    add_column :forecasts, :daily, :jsonb
    add_column :forecasts, :hourly, :jsonb
    add_column :forecasts, :tides, :jsonb
    add_column :forecasts, :tide, :jsonb
    add_index :forecasts, :location_id
  end
end
