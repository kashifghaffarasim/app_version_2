class CreateServiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :service_items do |t|

      t.string :name
      t.boolean :is_used
      t.integer :company_id
      t.integer :service_plan_id
      
      t.timestamps
    end
  end
end
