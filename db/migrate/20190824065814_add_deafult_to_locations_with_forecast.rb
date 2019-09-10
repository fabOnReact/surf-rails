class AddDeafultToLocationsWithForecast < ActiveRecord::Migration[5.1]
  def up
    change_column :locations, :with_forecast, :boolean, default: false
  end
  def down
    change_column :locations, :with_forecast, :boolean, default: nil
  end
end
