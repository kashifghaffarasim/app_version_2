class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      
      t.integer :job_id
      t.string  :name
      t.integer :quantity
      t.float   :unit_cost
      t.float   :total
      t.text    :description
      
      t.timestamps
    end
  end
end
