class RenameSpotToLocation < ActiveRecord::Migration[5.1]
  def change
    rename_table :spots, :locations
  end
end
