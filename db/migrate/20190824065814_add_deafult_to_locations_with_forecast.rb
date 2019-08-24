class AddDeafultToLocationsWithForecast < ActiveRecord::Migration[5.1]
  def change
    change_column :locations, :with_forecast, :boolean, default: false
  end
end
