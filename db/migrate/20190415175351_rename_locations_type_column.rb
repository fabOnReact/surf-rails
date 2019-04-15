class RenameLocationsTypeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :type, :bottom
  end
end
