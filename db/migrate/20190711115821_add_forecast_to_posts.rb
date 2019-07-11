class AddForecastToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :forecast, :jsonb
  end
end
