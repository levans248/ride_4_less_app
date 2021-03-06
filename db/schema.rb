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

ActiveRecord::Schema.define(version: 20160116074359) do

  create_table "uber_new_years_data", force: :cascade do |t|
    t.string   "ride_type",        limit: 255
    t.string   "neighborhood",     limit: 255
    t.float    "surge_multiplier", limit: 24
    t.integer  "time_estimate",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uber_world_data", force: :cascade do |t|
    t.float    "distance",         limit: 24
    t.string   "estimate",         limit: 255
    t.string   "ride_type",        limit: 255
    t.float    "surge_multiplier", limit: 24
    t.string   "city",             limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "wait_time",        limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",      limit: 255
    t.string   "uid",           limit: 255
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "token",         limit: 255
    t.string   "refresh_token", limit: 255
  end

end
