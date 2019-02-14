class AddAttachmentAttachmentToEmailNotifications < ActiveRecord::Migration[5.2]
  def self.up
    change_table :email_notifications do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :email_notifications, :attachment
  end
end