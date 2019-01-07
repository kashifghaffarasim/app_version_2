class Pool < ApplicationRecord
  
  belongs_to :user , optional: true
  has_many :jobs
  has_one :address
end
