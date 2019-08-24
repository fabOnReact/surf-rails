class AddWithForecastToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :with_forecast, :boolean
  end
end
