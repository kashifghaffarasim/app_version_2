class PoolServiceItem < ApplicationRecord
  
  belongs_to :service_plan
  belongs_to :service_item
  
end
