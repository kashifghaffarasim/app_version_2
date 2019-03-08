class AddDraftToEmailNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :email_notifications, :draft, :boolean, :default => false
  end
end
