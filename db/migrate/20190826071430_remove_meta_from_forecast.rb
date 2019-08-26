class RemoveMetaFromForecast < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :meta, :jsonb
  end
end
