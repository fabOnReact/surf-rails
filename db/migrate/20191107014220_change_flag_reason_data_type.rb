class ChangeFlagReasonDataType < ActiveRecord::Migration[5.1]
  def up
    change_column :posts, :flag_reason, :string
  end
  def down
    change_column :posts, :flag_reason, :jsonb
  end
end
