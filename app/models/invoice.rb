class Invoice < ApplicationRecord
  
  belongs_to :user
  belongs_to :job
  self.per_page = 30
end
