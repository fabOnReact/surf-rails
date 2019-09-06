class RemoveGoodWaveDirectionFromLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :best_wave_direction, :string, array: true
  end
end
