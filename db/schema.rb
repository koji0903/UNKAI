# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150618063243) do

  create_table "unkai_photos", force: :cascade do |t|
    t.text     "comment"
    t.date     "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weather_hours", force: :cascade do |t|
    t.string   "area",            null: false
    t.date     "date",            null: false
    t.datetime "date_time",       null: false
    t.float    "temperature"
    t.float    "wind_speed"
    t.string   "wind_direction"
    t.float    "railfall"
    t.float    "snow"
    t.float    "day_length"
    t.float    "insolation"
    t.float    "pressure"
    t.float    "sea_pressure"
    t.integer  "humidity"
    t.float    "stream_pressure"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "weather_hours", ["area", "date", "date_time"], name: "index_weather_hours_on_area_and_date_and_date_time", unique: true

  create_table "weathers", force: :cascade do |t|
    t.string   "area",                     null: false
    t.date     "date",                     null: false
    t.float    "ave_temperature"
    t.float    "max_temperature"
    t.float    "min_temperature"
    t.float    "rainfall"
    t.float    "max_rainfall"
    t.float    "day_length"
    t.float    "insolation"
    t.float    "max_snow"
    t.float    "total_snow"
    t.float    "ave_wind_speed"
    t.float    "max_wind_speed"
    t.string   "max_wind_direction"
    t.float    "momentary_wind_speed"
    t.string   "momentary_wind_direction"
    t.string   "most_direction"
    t.float    "ave_stream_pressure"
    t.integer  "ave_humidity"
    t.integer  "min_himidity"
    t.float    "ave_pressure"
    t.float    "ave_sea_pressure"
    t.float    "min_sea_pressure"
    t.float    "ave_cloud_amount"
    t.text     "outline06_18"
    t.text     "outline18_06"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "weathers", ["area", "date"], name: "index_weathers_on_area_and_date", unique: true

end
