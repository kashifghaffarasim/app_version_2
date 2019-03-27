class AddColumnPoolChemicalItems < ActiveRecord::Migration[5.2]
  def change
    
    add_column :pool_chemical_items, :value, :string, :default => ""
    
    change_column :services, :ph_low, :string, :default => "7.3"
    change_column :services, :ph_high, :string, :default => "7.6"
   
    change_column :services, :ch_low, :string, :default => "3"
    change_column :services, :ch_high, :string, :default => "7"
        
    change_column :services, :combined_ch_low, :string, :default => "0"
    change_column :services, :combined_ch_high, :string, :default => "1"
    
    change_column :services, :alkalinity_low, :string, :default => "90"
    change_column :services, :alkalinity_high, :string, :default => "150"
    
    change_column :services, :calcium_hardness_low, :string, :default => "200"
    change_column :services, :calcium_hardness_high, :string, :default => "400"
    
    change_column :services, :stabilizer_low, :string, :default => "30"
    change_column :services, :stabilizer_high, :string, :default => "60"
 
    change_column :services, :salt_low, :string, :default => "2400"
    change_column :services, :salt_high, :string, :default => "3400"
    
    change_column :services, :dissolved_soild_low, :string, :default => "0"
    change_column :services, :dissolved_soild_high, :string, :default => "2000"
    
    change_column :services, :saturation_index_low, :string, :default => "-0.4"
    change_column :services, :saturation_index_high, :string, :default => "0.4"
    
  end
end
