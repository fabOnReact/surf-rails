class AddWeavePeriodToForecast < ActiveRecord::Migration[5.1]
  def change
    add_column :forecasts, :wave_period, :integer
  end
end
