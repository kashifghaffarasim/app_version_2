class Job < ApplicationRecord
  
  belongs_to :pool , optional: true
  belongs_to :user , optional: true
  belongs_to :company , optional: true
  
  has_many :line_items
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
end
