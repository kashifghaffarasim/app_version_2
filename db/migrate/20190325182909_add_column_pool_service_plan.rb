class AddColumnPoolServicePlan < ActiveRecord::Migration[5.2]
  def change
    add_column :pools, :service_plan_id, :integer
  end
end
