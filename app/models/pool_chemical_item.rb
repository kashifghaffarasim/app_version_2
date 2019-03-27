class PoolChemicalItem < ApplicationRecord
  
  belongs_to :chamical_item
  belongs_to :pool
  
end
