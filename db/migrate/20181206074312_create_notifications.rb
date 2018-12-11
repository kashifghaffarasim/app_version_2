class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|

      t.string  :name
      t.string  :message
      t.string  :description
      t.integer :user_notification_id
      
      t.timestamps
    end
  end
end
