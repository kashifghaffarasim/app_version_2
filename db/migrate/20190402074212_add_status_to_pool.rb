class AddStatusToPool < ActiveRecord::Migration[5.2]
  def change
    add_column :pools,:disable, :boolean,:default => false
  end
end
