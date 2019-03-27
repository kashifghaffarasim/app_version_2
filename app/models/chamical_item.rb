class ChamicalItem < ApplicationRecord
  
  belongs_to :company
  has_many :pool_chemical_items
  
end
