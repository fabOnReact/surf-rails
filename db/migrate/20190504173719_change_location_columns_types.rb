class ChangeLocationColumnsTypes < ActiveRecord::Migration[5.1]
  def up
    execute "ALTER TABLE locations ALTER COLUMN latitude TYPE double precision USING NULLIF(latitude, '')::double precision"
    execute "ALTER TABLE locations ALTER COLUMN longitude TYPE double precision USING NULLIF(longitude, '')::double precision"
  end

  def down
    execute "ALTER TABLE locations ALTER COLUMN latitude TYPE text USING  latitude::text"
    execute "ALTER TABLE locations ALTER COLUMN longitude TYPE text USING longitude::text"
  end  
end
