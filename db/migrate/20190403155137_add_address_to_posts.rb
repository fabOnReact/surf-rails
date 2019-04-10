class AddAddressToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :address, :string
  end
end
