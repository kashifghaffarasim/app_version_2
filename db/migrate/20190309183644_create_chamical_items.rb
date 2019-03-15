class CreateChamicalItems < ActiveRecord::Migration[5.2]
  def change
    create_table :chamical_items do |t|

      t.string :name
      t.integer :company_id
      t.boolean :is_used
      
      t.timestamps
    end
  end
end
