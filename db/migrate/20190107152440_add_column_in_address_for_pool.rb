class AddColumnInAddressForPool < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :pool_id, :integer
    add_column :pools, :pool_activity, :string
    add_column :pools, :company_id, :integer
  end
end
