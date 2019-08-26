class RenameForecastColumnToWave < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :forecast, :wave
  end
end
