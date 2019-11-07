class AddReportedToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :reported, :boolean, default: false
  end
end
