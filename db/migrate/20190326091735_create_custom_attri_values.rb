class CreateCustomAttriValues < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_attri_values do |t|
      
      t.string :value
      t.integer :model_id
      t.integer :custom_field_id
      
      t.timestamps
    end
  end
end
