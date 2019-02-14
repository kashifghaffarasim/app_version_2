class AddEmailTypeToNotificationOptions < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_options, :email_subject, :string
    add_column :notification_options, :email_content, :text
  end
end
