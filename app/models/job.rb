class Job < ApplicationRecord
  
  belongs_to :pool , optional: true
  belongs_to :user , optional: true
  belongs_to :company , optional: true
end
