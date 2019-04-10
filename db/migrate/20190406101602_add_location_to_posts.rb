class AddLocationToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :location, :string
  end
end
