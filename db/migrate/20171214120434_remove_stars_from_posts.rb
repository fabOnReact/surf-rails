class RemoveStarsFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :stars, :integer
  end
end
