class AddDeafultToLocationForecast < ActiveRecord::Migration[5.1]
  def up
    change_column :locations, :forecast, :jsonb, :default => []
  end

  def down
    change_column :locations, :forecast, :jsonb, :default => nil
  end
end
