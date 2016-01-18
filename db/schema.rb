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

ActiveRecord::Schema.define(version: 20160117162952) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "prizes", force: :cascade do |t|
    t.string   "city",                  limit: 255
    t.integer  "free_charge",           limit: 4
    t.decimal  "free_charge_ratio",                 precision: 10, scale: 8
    t.integer  "fifty_discount",        limit: 4
    t.decimal  "fifty_discount_ratio",              precision: 10, scale: 8
    t.integer  "thirty_discount",       limit: 4
    t.decimal  "thirty_discount_ratio",             precision: 10, scale: 8
    t.integer  "ten_discount",          limit: 4
    t.decimal  "ten_discount_ratio",                precision: 10, scale: 8
    t.integer  "red_envelop",           limit: 4
    t.decimal  "red_envelop_ratio",                 precision: 10, scale: 8
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "city",       limit: 255
    t.string   "prize",      limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "state",      limit: 255
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "serials", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "open_id",    limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "serial_no",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "openid",     limit: 255
    t.string   "cell",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "state",      limit: 4,   default: 0
    t.integer  "score",      limit: 4
  end

  add_foreign_key "records", "users"
end
