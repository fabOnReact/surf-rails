class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :string, options: {limit: 30}
    add_index :users, [:id, :authentication_token], unique: true
  end
end
