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

ActiveRecord::Schema.define(version: 2018_12_11_183543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_name"
    t.integer "address_type"
    t.string "city_name"
    t.string "state_name"
    t.string "country_name"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "address_id"
    t.string "latitude"
    t.string "logitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.integer "address_id"
    t.integer "pool_id"
    t.string "name"
    t.datetime "start_time"
    t.string "amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "name"
    t.string "message"
    t.string "description"
    t.integer "user_notification_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pools", force: :cascade do |t|
    t.integer "user_id"
    t.integer "address_id"
    t.string "name"
    t.string "description"
    t.string "pool_type"
    t.string "pool_shape"
    t.string "pool_size"
    t.string "pool_gallonage"
    t.string "equip_pump_brand"
    t.string "equip_model"
    t.string "equip_horsepower"
    t.string "equip_service_factor"
    t.string "equip_voltage"
    t.string "filter_brand"
    t.string "filter_model"
    t.string "filter_type"
    t.string "filter_cartridge"
    t.string "filter_date_replaced"
    t.string "filter_de"
    t.string "heater_brand"
    t.string "heater_model"
    t.string "heater_size"
    t.string "heater_type"
    t.string "time_clock_brand"
    t.string "time_clock_model"
    t.string "time_clock_voltage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.float "depth"
    t.float "depth2"
    t.float "length"
    t.float "width"
    t.float "width2"
    t.float "diameter"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.integer "action_type"
    t.integer "reciver_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "company_id"
    t.integer "plan_id"
    t.string "demo_code"
    t.integer "address_id"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
