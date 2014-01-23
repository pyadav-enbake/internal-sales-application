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

ActiveRecord::Schema.define(version: 20140123092112) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "terms_and_conditions",   default: false
    t.string   "role"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cabinet_types", force: true do |t|
    t.string   "name"
    t.integer  "status",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "quote_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "contractors", force: true do |t|
    t.integer  "admin_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.integer  "status",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  create_table "countertop_designs", force: true do |t|
    t.string   "name"
    t.integer  "status",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.integer  "contractor_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "phone"
    t.integer  "status",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "email_templates", force: true do |t|
    t.string   "template_name"
    t.text     "message_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extra_categories", force: true do |t|
    t.string   "name"
    t.integer  "quote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faq_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "display_order"
    t.integer  "status",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: true do |t|
    t.integer  "faq_category_id"
    t.text     "question"
    t.text     "answer"
    t.integer  "display_order"
    t.integer  "status",          limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_logs", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "login_time"
    t.datetime "logout_time"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  create_table "products", force: true do |t|
    t.integer  "subcategory_id"
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.string   "measurement_type"
    t.integer  "status",           limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quote_products", force: true do |t|
    t.integer  "quote_id"
    t.integer  "product_id"
    t.integer  "category_id"
    t.integer  "quantity"
    t.float    "total_price"
    t.integer  "status",        limit: 1
    t.string   "header_option",           default: "No"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.integer  "customer_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                  limit: 1, default: 1
    t.date     "delivery_date"
    t.string   "sales_closing_potential"
    t.integer  "cabinet_type_id"
    t.integer  "countertop_design_id"
    t.text     "cabinet_types_info"
    t.text     "countertop_designs_info"
    t.integer  "contractor_id"
    t.text     "note"
  end

  create_table "static_pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.integer  "status",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
