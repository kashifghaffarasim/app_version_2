class Pool < ApplicationRecord
  
  belongs_to :user , optional: true
  has_one :pool_datum
  has_many :jobs
  has_one :address
  belongs_to :service_plan
  
  
  
end
