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

ActiveRecord::Schema.define(version: 20161123164306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "symbol"
    t.index ["code"], name: "index_currencies_on_code", unique: true, using: :btree
  end

  create_table "currency_rates", force: :cascade do |t|
    t.integer  "from_currency_id"
    t.integer  "to_currency_id"
    t.decimal  "buy",              precision: 8, scale: 2
    t.decimal  "sell",             precision: 8, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["from_currency_id"], name: "index_currency_rates_on_from_currency_id", using: :btree
    t.index ["to_currency_id"], name: "index_currency_rates_on_to_currency_id", using: :btree
  end

  add_foreign_key "currency_rates", "currencies", column: "from_currency_id"
  add_foreign_key "currency_rates", "currencies", column: "to_currency_id"
end
