class AddFlagDataToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :flag_reason, :string
    add_column :posts, :flag_data, :jsonb
  end
end
