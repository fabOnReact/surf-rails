class AddCreationDateToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :creation_date, :string
  end
end
