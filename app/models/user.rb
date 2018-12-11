class User < ApplicationRecord
  rolify
  
  has_one :company
  has_many :pools
  has_many :addresses
  has_many :user_notifications
  
end
