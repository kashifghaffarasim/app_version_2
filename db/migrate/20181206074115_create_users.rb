class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      
      t.string :first_name
      t.string :last_name
      t.integer :company_id
      t.integer :plan_id
      t.string  :demo_code
      t.integer :address_id
      t.string  :username 
      t.timestamps
    end
  end
end
