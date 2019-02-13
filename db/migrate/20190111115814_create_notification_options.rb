class CreateNotificationOptions < ActiveRecord::Migration[5.2]
	def change
		create_table :notification_options do |t|
			t.text :subject
			t.string :message_type
			t.text :message_content
			t.integer :company_id
			t.timestamps
		end
	end
end