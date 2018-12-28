class AddStatusToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :status, :string
    add_column :jobs, :end_time, :datetime
  end
end
