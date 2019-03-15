class CreatePoolChemicalItems < ActiveRecord::Migration[5.2]
  def change
    create_table :pool_chemical_items do |t|

      
      t.integer  :chamical_item_id
      t.integer  :pool_id
      t.boolean  :is_used
      
      t.timestamps
    end
  end
end
