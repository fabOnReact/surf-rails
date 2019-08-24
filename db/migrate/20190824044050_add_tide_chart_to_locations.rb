class AddTideChartToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :tide_chart, :jsonb
  end
end
