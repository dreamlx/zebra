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

ActiveRecord::Schema.define(version: 20161115173346) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "address",         limit: 255
    t.string   "cell",            limit: 255
    t.string   "contact",         limit: 255
    t.string   "email",           limit: 255
    t.string   "website",         limit: 255
    t.string   "state",           limit: 255
    t.string   "role",            limit: 255
  end

  create_table "cell_codes", force: :cascade do |t|
    t.string   "cell",       limit: 255
    t.integer  "code",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "from",          limit: 255
    t.string   "from_name",     limit: 255
    t.string   "serial_number", limit: 255
    t.string   "field_1",       limit: 255
    t.string   "field_2",       limit: 255
    t.string   "field_8",       limit: 255
    t.string   "field_9",       limit: 255
    t.string   "field_15",      limit: 255
    t.string   "gen_code",      limit: 255
    t.string   "status",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "extentions", force: :cascade do |t|
    t.integer  "product_id",      limit: 4
    t.string   "extention_name",  limit: 255
    t.integer  "extention_type",  limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "extention_value", limit: 255
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "shop_store_id", limit: 4
    t.integer  "serial_id",     limit: 4
    t.date     "order_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "orders", ["shop_store_id"], name: "index_orders_on_shop_store_id", using: :btree

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

  create_table "products", force: :cascade do |t|
    t.string   "product_name",  limit: 255
    t.string   "product_image", limit: 255
    t.integer  "admin_id",      limit: 4
    t.string   "state",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "score",         limit: 4
    t.string   "product_logo",  limit: 255
    t.string   "desc",          limit: 255
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

  create_table "scanlogs", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "serial_id",     limit: 4
    t.integer  "current_score", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "serials", force: :cascade do |t|
    t.string   "phone",              limit: 255
    t.string   "open_id",            limit: 255
    t.integer  "user_id",            limit: 4
    t.string   "serial_no",          limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "product_id",         limit: 4
    t.string   "state",              limit: 255
    t.integer  "store_assistant_id", limit: 4
  end

  add_index "serials", ["product_id"], name: "index_serials_on_product_id", using: :btree

  create_table "shop_stores", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "code",       limit: 255
    t.string   "contact",    limit: 255
    t.string   "mobile",     limit: 255
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "form",          limit: 255
    t.string   "form_name",     limit: 255
    t.string   "serial_number", limit: 255
    t.string   "field_1",       limit: 255
    t.string   "field_5",       limit: 255
    t.string   "field_6",       limit: 255
    t.string   "field_7",       limit: 255
    t.string   "field_8",       limit: 255
    t.string   "field_9",       limit: 255
    t.string   "creator_name",  limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "thirdparties", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "image",      limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "useradminrels", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "admin_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "useradminrels", ["admin_id"], name: "index_useradminrels_on_admin_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "openid",     limit: 255
    t.string   "cell",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "state",      limit: 255, default: "0"
    t.integer  "score",      limit: 4
    t.string   "image",      limit: 255
    t.date     "birthday"
    t.string   "level",      limit: 255
    t.string   "type",       limit: 255
    t.string   "memo",       limit: 255
    t.string   "code",       limit: 255
    t.string   "city",       limit: 255
    t.string   "store",      limit: 255
    t.string   "department", limit: 255
  end

  add_foreign_key "records", "users"
end
