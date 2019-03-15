class CreatePoolServiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :pool_service_items do |t|

      t.boolean :is_used
      t.integer :service_item_id
      t.integer :service_plan_id
      
      t.timestamps
    end
  end
end
