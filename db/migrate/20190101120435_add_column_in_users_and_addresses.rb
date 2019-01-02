class AddColumnInUsersAndAddresses < ActiveRecord::Migration[5.2]
  def change
    
    add_column :users ,  :company_name, :string
    add_column :users , :mobile_number , :string
    add_column :users , :phone_number , :string
    add_column :users , :personal_email , :string
    
    
  end
end
