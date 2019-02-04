class Address < ApplicationRecord
  
  belongs_to :user ,optional: true
  belongs_to :company ,optional: true
  belongs_to :pool ,optional: true
  
  def full_address
     self.city_name + ", "+ self.state_name + ", " +  self.country_name
  end
end
