# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190711115821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "direction"
    t.string "experience"
    t.string "frequency"
    t.string "bottom"
    t.string "wave_quality"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "country"
    t.string "area"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alternative_name"
    t.string "pictures", array: true
    t.jsonb "areas", default: "{}", null: false
    t.index ["areas"], name: "index_locations_on_areas", using: :gin
    t.index ["country", "area", "name"], name: "index_locations_on_country_and_area_and_name", unique: true
    t.index ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"
    t.index ["pictures"], name: "index_locations_on_pictures", using: :gin
  end

  create_table "posts", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "picture"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "city"
    t.integer "likes", default: 0
    t.integer "favorite", default: [], array: true
    t.jsonb "forecast"
    t.index ["favorite"], name: "index_posts_on_favorite", using: :gin
    t.index ["latitude", "longitude"], name: "index_posts_on_latitude_and_longitude"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "authentication_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id", "authentication_token"], name: "index_users_on_id_and_authentication_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "posts", "users"
end
