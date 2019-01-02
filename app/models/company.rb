class Company < ApplicationRecord
  
  has_one :addresses
  has_many :users
  
  def save_address(params)
    Address.create(company_id: self.id, 
      address_name: params[:address_name], 
      address_type: 'primary', 
      city_name:  params[:city_name], 
      state_name: nil, 
      country_name: params[:country_name], 
      zipcode: params[:zip_code])
  end
  
end
