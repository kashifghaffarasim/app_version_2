class CreatePoolData < ActiveRecord::Migration[5.2]
	def change
		create_table :pool_data do |t|
			t.integer :pool_id
			t.string :pool_type
			t.string :shape
			t.string :type_manufacturer
			t.string :type_model
			t.string :type_serial_number
			t.string :type_color
			t.string :type_voltage
			t.string :surface_material
			t.string :equip_pump_brand
			t.string :equip_model
			t.string :equip_horsepower
			t.string :equip_service_factor
			t.string :equip_voltage
			t.string :filter_brand
			t.string :filter_model
			t.string :filter_type
			t.string :filter_cartridge
			t.string :cartridge_size
			t.string :cartridge_part
			t.string :cartridge_date
			t.string :filter_sand_model
			t.string :filter_sand_size
			t.string :filter_date_replaced
			t.string :filter_de
			t.string :heater_brand
			t.string :heater_model
			t.string :heater_size
			t.string :heater_type
			t.string :time_clock_brand
			t.string :time_clock_model
			t.string :time_clock_voltage
			t.timestamps
		end
	end
end
