class AddEstimateMapToPools < ActiveRecord::Migration[5.2]
  def change
    add_column :pools, :estimate_map, :string
  end
end
