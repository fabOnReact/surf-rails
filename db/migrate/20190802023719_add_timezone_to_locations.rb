class AddTimezoneToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :timezone, :jsonb
  end
end
