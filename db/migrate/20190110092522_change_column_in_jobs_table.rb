class ChangeColumnInJobsTable < ActiveRecord::Migration[5.2]
  def change
    
    add_column :jobs, :job_number, :string
    add_column :jobs, :sub_total , :float
    add_column :jobs, :discount , :float
    add_column :jobs, :tax, :float
    add_column :jobs, :grand_total, :float
    add_column :jobs, :messages, :text
    add_column :jobs, :job_type, :string
    add_column :jobs, :start_date, :datetime
    add_column :jobs, :end_date, :datetime
    add_column :jobs, :assign_to , :integer
    
    remove_column :jobs, :address_id
    remove_column :jobs, :name
    remove_column :jobs, :amount
    
  end
end
