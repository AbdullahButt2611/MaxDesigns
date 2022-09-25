# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_25_134521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "amount_receiveds", force: :cascade do |t|
    t.money "money_received", scale: 2
    t.integer "mode"
    t.text "purpose"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.index ["project_id"], name: "index_amount_receiveds_on_project_id"
    t.index ["user_id"], name: "index_amount_receiveds_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contactNumber"
    t.string "company"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.money "price", scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vendor_id", null: false
    t.integer "item_type", default: 0
    t.index ["vendor_id"], name: "index_items_on_vendor_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.bigint "vendor_id", null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_order_details_on_item_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["vendor_id"], name: "index_order_details_on_vendor_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_type"
    t.datetime "order_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id", null: false
    t.index ["project_id"], name: "index_orders_on_project_id"
  end

  create_table "project_details", force: :cascade do |t|
    t.datetime "date"
    t.string "task"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id", null: false
    t.bigint "order_id"
    t.bigint "user_id", null: false
    t.index ["order_id"], name: "index_project_details_on_order_id"
    t.index ["project_id"], name: "index_project_details_on_project_id"
    t.index ["user_id"], name: "index_project_details_on_user_id"
    t.check_constraint "project_id IS NOT NULL", name: "project_details_project_id_null"
    t.check_constraint "user_id IS NOT NULL", name: "project_details_user_id_null"
  end

  create_table "projects", force: :cascade do |t|
    t.string "client_name"
    t.string "contact"
    t.text "location"
    t.money "amount_promised", scale: 2
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_type", default: 0
    t.integer "project_status", default: 0
    t.string "name"
    t.money "amount_present", scale: 2
    t.string "avatar"
  end

  create_table "transactions", force: :cascade do |t|
    t.money "amount_paid", scale: 2
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.bigint "user_id", null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "name"
    t.string "contact"
    t.string "qualification"
    t.integer "pay"
    t.integer "activity_status", default: 0
    t.integer "user_roles"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_historys", force: :cascade do |t|
    t.money "amount", scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.bigint "vendor_id", null: false
    t.datetime "date"
    t.index ["order_id"], name: "index_vendor_historys_on_order_id"
    t.index ["vendor_id"], name: "index_vendor_historys_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "company_name"
    t.text "address"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_type"
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "amount_receiveds", "projects"
  add_foreign_key "amount_receiveds", "users"
  add_foreign_key "items", "vendors"
  add_foreign_key "order_details", "items"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "vendors"
  add_foreign_key "orders", "projects"
  add_foreign_key "project_details", "orders"
  add_foreign_key "project_details", "projects"
  add_foreign_key "project_details", "users"
  add_foreign_key "transactions", "orders"
  add_foreign_key "transactions", "users"
  add_foreign_key "vendor_historys", "orders"
  add_foreign_key "vendor_historys", "vendors"
  add_foreign_key "vendors", "users"
end
