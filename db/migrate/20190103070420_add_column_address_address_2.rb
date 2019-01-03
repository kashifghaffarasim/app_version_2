class AddColumnAddressAddress2 < ActiveRecord::Migration[5.2]
  def change
    
    add_column :pools, :company_id, :integer
  end
end
