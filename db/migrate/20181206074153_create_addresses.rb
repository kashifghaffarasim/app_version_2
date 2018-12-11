class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      
      t.string  :address_name
      t.integer :address_type
      t.string  :city_name
      t.string  :state_name
      t.string  :country_name
      t.string  :zipcode
    
      t.timestamps
    end
  end
end
