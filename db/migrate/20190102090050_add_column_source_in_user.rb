class AddColumnSourceInUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :source, :string 
  end
end
