class RenameLocationsJsonColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :tide, :tides
    rename_column :locations, :wave, :waves
  end
end
