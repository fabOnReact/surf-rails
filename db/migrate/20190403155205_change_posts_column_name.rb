class ChangePostsColumnName < ActiveRecord::Migration[5.1]
  def up
    remove_column :posts, :location, :string
    add_column :posts, :city, :string
  end

  def down
    remove_column :posts, :city, :string
    add_column :posts, :location, :string
  end
end
