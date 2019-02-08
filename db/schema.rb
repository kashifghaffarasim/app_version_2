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

ActiveRecord::Schema.define(version: 2019_02_08_111854) do

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
    t.integer "user_id"
    t.integer "company_id"
    t.integer "pool_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "address_id"
    t.string "latitude"
    t.string "logitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.string "start_week"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "email_notifications", force: :cascade do |t|
    t.string "user_email"
    t.string "subject"
    t.string "body"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.bigint "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "job_assign_visits", force: :cascade do |t|
    t.integer "job_id"
    t.string "start_time"
    t.string "end_time"
    t.integer "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status", default: "In Progresss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.integer "pool_id"
    t.datetime "start_time"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.datetime "end_time"
    t.string "job_number"
    t.float "sub_total"
    t.float "discount"
    t.float "tax"
    t.float "grand_total"
    t.text "messages"
    t.string "job_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "assign_to"
    t.float "deposit"
    t.integer "rating"
    t.integer "customer_id"
    t.string "schudle"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "job_id"
    t.string "name"
    t.integer "quantity"
    t.float "unit_cost"
    t.float "total"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_options", force: :cascade do |t|
    t.text "subject"
    t.string "message_type"
    t.text "message_content"
    t.integer "company_id"
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

  create_table "plans", force: :cascade do |t|
    t.string "plan_name"
    t.string "user_detail"
    t.string "cutomer_detail"
    t.string "notification_detail"
    t.string "trail_detail"
    t.float "plan_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pool_data", force: :cascade do |t|
    t.integer "pool_id"
    t.string "pool_type"
    t.string "shape"
    t.string "type_manufacturer"
    t.string "type_model"
    t.string "type_serial_number"
    t.string "type_color"
    t.string "type_voltage"
    t.string "surface_material"
    t.string "equip_pump_brand"
    t.string "equip_model"
    t.string "equip_horsepower"
    t.string "equip_service_factor"
    t.string "equip_voltage"
    t.string "filter_brand"
    t.string "filter_model"
    t.string "filter_type"
    t.string "filter_cartridge"
    t.string "cartridge_size"
    t.string "cartridge_part"
    t.string "cartridge_date"
    t.string "filter_sand_model"
    t.string "filter_sand_size"
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
  end

  create_table "pool_settings", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pools", force: :cascade do |t|
    t.integer "user_id"
    t.integer "address_id"
    t.string "pool_name"
    t.string "pool_description"
    t.string "pool_type"
    t.string "pool_volume"
    t.string "pool_volume2"
    t.string "pool_gate_code"
    t.string "pool_source_type"
    t.string "pool_lifeguards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pool_activity"
    t.integer "company_id"
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string "cacheable_type"
    t.bigint "cacheable_id"
    t.float "avg", null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"
    t.index ["cacheable_type", "cacheable_id"], name: "index_rating_caches_on_cacheable_type_and_cacheable_id"
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

  create_table "sms", force: :cascade do |t|
    t.string "user_number"
    t.string "body"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "company_name"
    t.string "mobile_number"
    t.string "phone_number"
    t.string "personal_email"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "source"
    t.string "status"
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
