class AddWeavePeriodToForecast < ActiveRecord::Migration[5.1]
  def up
    create_table "forecasts", force: :cascade do |t|
      t.bigint "location_id"
      t.datetime "time"
      t.float "sea_level"
      t.float "wind_speed"
      t.float "wave_height"
      t.float "swell_height"
      t.float "swell_period"
      t.float "wave_direction"
      t.float "wind_direction"
      t.float "swell_direction"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["location_id"], name: "index_forecasts_on_location_id"
      t.index ["time"], name: "index_forecasts_on_time", unique: true
    end
    add_column :forecasts, :wave_period, :integer
  end
  def down
    drop_table :forecasts
  end
end
