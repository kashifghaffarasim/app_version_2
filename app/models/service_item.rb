class ServiceItem < ApplicationRecord
  
  belongs_to :company , optional: true
end
