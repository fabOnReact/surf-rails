class RemoveLocationFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :location, :string
  end
end
