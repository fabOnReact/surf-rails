class AddTideToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :tide, :jsonb
  end
end
