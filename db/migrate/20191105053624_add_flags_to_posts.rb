class AddFlagsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :flag_reason, :jsonb
  end
end
