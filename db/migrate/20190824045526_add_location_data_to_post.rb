class AddLocationDataToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :location_data, :jsonb
  end
end
