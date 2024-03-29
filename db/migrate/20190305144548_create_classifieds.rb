class CreateClassifieds < ActiveRecord::Migration[5.2]
	def change
		create_table :classifieds do |t|
			t.string :privacy
			t.string :contact_phone
			t.string :contact_text
			t.string :phone_number
			t.string :contact_name
			t.string :posting_title
			t.string :specific_location
			t.string :postal_code
			t.text :posting_body
			t.boolean :show_on_map
			t.string :street
			t.string :city
			t.string :state
			t.string :zipcode
			t.boolean :contact_ok
			t.string  :license
			t.string :license_info
			t.integer :user_id
			t.integer :picture_id
			t.timestamps
		end
	end
end
