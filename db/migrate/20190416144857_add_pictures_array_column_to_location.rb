class AddPicturesArrayColumnToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :pictures, :string, array: true
    add_index :locations, :pictures, using: 'gin'
  end
end
