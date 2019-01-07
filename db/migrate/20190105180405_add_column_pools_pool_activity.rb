class AddColumnPoolsPoolActivity < ActiveRecord::Migration[5.2]
  def change
    drop_table :pools
    create_table :pools do |t|
      t.integer :user_id
      t.integer :address_id
      t.string  :pool_name
      t.string  :pool_description
      t.string  :pool_type
      t.string  :pool_volume 
      t.string  :pool_volume2
      t.string  :pool_gate_code
      t.string  :pool_source_type
      t.string  :pool_lifeguards
      t.timestamps
    end
  end
end
