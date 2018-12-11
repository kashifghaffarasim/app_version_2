class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|

 
      t.integer :company_id
      t.integer :user_id
      t.integer :address_id
      t.integer :pool_id
      
      t.string   :name
      t.datetime :start_time
      t.string   :amount
      t.string   :description
      t.timestamps
    end
  end
end
