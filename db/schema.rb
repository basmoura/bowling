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

ActiveRecord::Schema.define(version: 2020_02_03_195023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bowling_houses", force: :cascade do |t|
    t.string "name"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frames", force: :cascade do |t|
    t.integer "first_pins_dropped"
    t.integer "second_pins_dropped"
    t.integer "third_pins_dropped"
    t.boolean "strike", default: false
    t.boolean "spare", default: false
    t.integer "points"
    t.integer "status"
    t.integer "game_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "status"
    t.integer "lane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lanes", force: :cascade do |t|
    t.integer "status"
    t.integer "bowling_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
