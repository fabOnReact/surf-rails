class AddLocationReferenceToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :location_id, :integer
    add_index :posts, :location_id
  end
end
