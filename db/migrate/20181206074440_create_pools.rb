class CreatePools < ActiveRecord::Migration[5.2]
  def change
    create_table :pools do |t|

        t.integer :user_id
        t.integer :address_id
        t.string  :name
        t.string  :description
        t.string   "pool_type"
        t.string   "pool_shape"
        t.string   "pool_size"
        t.string   "pool_gallonage"
        t.string   "equip_pump_brand"
        t.string   "equip_model"
        t.string   "equip_horsepower"
        t.string   "equip_service_factor"
        t.string   "equip_voltage"
        t.string   "filter_brand"
        t.string   "filter_model"
        t.string   "filter_type"
        t.string   "filter_cartridge"
        t.string   "filter_date_replaced"
        t.string   "filter_de"
        t.string   "heater_brand"
        t.string   "heater_model"
        t.string   "heater_size"
        t.string   "heater_type"
        t.string   "time_clock_brand"
        t.string   "time_clock_model"
        t.string   "time_clock_voltage"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "property_id"
        t.float    "depth",                limit: 24
        t.float    "depth2",               limit: 24
        t.float    "length",               limit: 24
        t.float    "width",                limit: 24
        t.float    "width2",               limit: 24
        t.float    "diameter",             limit: 24
      t.timestamps
    end
  end
end
