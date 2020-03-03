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

ActiveRecord::Schema.define(version: 2020_03_02_103600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipt_items", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.integer "tax"
    t.bigint "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receipt_id"], name: "index_receipt_items_on_receipt_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "company"
    t.integer "total_amount"
    t.date "date"
    t.integer "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "category"
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_receipts_on_trip_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "trip_budgets", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "budget_id"
    t.integer "remaining_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_trip_budgets_on_budget_id"
    t.index ["trip_id"], name: "index_trip_budgets_on_trip_id"
  end

  create_table "trip_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_users_on_trip_id"
    t.index ["user_id"], name: "index_trip_users_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "destination"
    t.string "purpose"
    t.string "customer"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.boolean "manager", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "receipt_items", "receipts"
  add_foreign_key "receipts", "trips"
  add_foreign_key "receipts", "users"
  add_foreign_key "trip_budgets", "budgets"
  add_foreign_key "trip_budgets", "trips"
  add_foreign_key "trip_users", "trips"
  add_foreign_key "trip_users", "users"
end
