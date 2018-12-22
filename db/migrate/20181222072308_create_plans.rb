class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      
      t.string :plan_name
      t.string :user_detail
      t.string :cutomer_detail
      t.string :notification_detail
      t.string :trail_detail
      t.float  :plan_price
      t.timestamps
    end
  end
end
