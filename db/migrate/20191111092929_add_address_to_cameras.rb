class AddAddressToCameras < ActiveRecord::Migration[5.1]
  def change
    add_column :cameras, :address, :string
  end
end
