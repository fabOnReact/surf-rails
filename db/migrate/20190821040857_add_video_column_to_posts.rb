class AddVideoColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :video, :jsonb
  end
end
