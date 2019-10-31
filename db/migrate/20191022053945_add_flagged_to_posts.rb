class AddFlaggedToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :flagged, :boolean, :default => false
    add_index :posts, :flagged
  end
end
