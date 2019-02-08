class AddColumnJobCustomerId < ActiveRecord::Migration[5.2]
  def change
    
    add_column :jobs, :customer_id , :integer
    add_column :jobs, :schudle, :string
  end
end
