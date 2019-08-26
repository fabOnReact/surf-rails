class ChangeWavesIntoForecast < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :waves, :forecast
  end
end
