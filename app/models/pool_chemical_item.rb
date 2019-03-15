class PoolChemicalItem < ApplicationRecord
  
  belongs_to :chemical_item
  belongs_to :pool
end
