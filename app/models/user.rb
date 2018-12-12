class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify
  
  has_one :company
  has_many :pools
  has_many :addresses
  has_many :user_notifications
  
end
