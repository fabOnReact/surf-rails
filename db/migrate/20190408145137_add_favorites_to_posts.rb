class AddFavoritesToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :favorites, :integer, array: true, default: []
    add_index :posts, :favorites, using: 'gin'
  end
end
