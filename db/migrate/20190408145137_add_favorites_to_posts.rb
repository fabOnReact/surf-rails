class AddFavoritesToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :favorite, :integer, array: true, default: []
    add_index :posts, :favorite, using: 'gin'
  end
end
