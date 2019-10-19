class RemoveJsonColumnsFromForecasts < ActiveRecord::Migration[5.1]
  def change
    remove_column :forecasts, :tide, :jsonb
    remove_column :forecasts, :hourly, :jsonb
    remove_column :forecasts, :daily, :jsonb
  end
end
