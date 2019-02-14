class CreateEmailNotifications < ActiveRecord::Migration[5.2]
	def change
		create_table :email_notifications do |t|
			t.string :user_email
			t.string :subject
			t.string :body
			t.integer :sender_id
			t.integer :receiver_id
			t.boolean :status ,:default => false
			t.timestamps
		end
	end
end