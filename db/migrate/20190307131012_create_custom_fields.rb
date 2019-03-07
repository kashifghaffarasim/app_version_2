class CreateCustomFields < ActiveRecord::Migration[5.2]
	def change
		create_table :custom_fields do |t|
			t.string :applies_to
			t.string :name  
			t.string :value_type
			t.integer :user_id 
			t.string :default
			t.timestamps
		end
	end
end
