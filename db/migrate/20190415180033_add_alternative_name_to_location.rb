class AddAlternativeNameToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :alternative_name, :string
  end
end
