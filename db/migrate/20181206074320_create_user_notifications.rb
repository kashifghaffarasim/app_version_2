class CreateUserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_notifications do |t|

      t.integer  :action_type
      t.integer :reciver_id
      t.integer :sender_id
      t.timestamps
      
    end
  end
end
