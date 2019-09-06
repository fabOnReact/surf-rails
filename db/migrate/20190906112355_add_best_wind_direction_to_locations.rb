class AddBestWindDirectionToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :best_wind_direction, :string, array: true
    add_column :locations, :best_wave_direction, :string, array: true
    add_column :locations, :best_swell_direction, :string, array: true
  end
end
