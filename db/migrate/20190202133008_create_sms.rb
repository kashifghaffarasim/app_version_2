class CreateSms < ActiveRecord::Migration[5.2]
	def change
		create_table :sms do |t|
			t.string :user_number
			t.string :body
			t.integer :sender_id
			t.integer :receiver_id
			t.boolean :status ,:default => false
			t.timestamps
		end
	end
end
