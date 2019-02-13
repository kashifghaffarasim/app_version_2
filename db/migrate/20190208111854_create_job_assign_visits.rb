class CreateJobAssignVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :job_assign_visits do |t|
      
      t.integer :job_id
      t.string :start_time
      t.string :end_time
      t.integer :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.string  :status , :default => "Pending"
      t.timestamps
    end
  end
end
