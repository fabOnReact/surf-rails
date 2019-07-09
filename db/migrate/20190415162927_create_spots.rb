class CreateSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :spots do |t|
      t.string :direction
      t.string :experience
      t.string :frequency
      t.string :type
      t.string :wave_quality
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :country
      t.string :area
      t.string :address

      t.timestamps
    end

    add_index :spots, [:country, :name], unique: true
  end
end
