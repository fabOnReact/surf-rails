class RemoveWithForecastFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :with_forecast, :boolean
  end
end
