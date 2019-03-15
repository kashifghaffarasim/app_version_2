class CreateServicePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :service_plans do |t|

      t.string  :name
      t.string  :description
      t.float   :unit_cost
      t.integer :company_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
