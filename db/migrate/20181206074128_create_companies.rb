class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      
      t.string  :name
      t.integer :address_id
      t.string  :latitude
      t.string  :logitude
      
      t.timestamps
    end
  end
end
