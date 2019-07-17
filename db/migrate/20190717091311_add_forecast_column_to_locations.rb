class AddForecastColumnToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :forecast, :jsonb
    remove_column :posts, :forecast, :jsonb
  end
end
