class Company < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  has_one :address
  has_many :users
  
  def save_address(params)
    a = Address.create(company_id: self.id, 
      address_name: params[:address_name], 
      address_type: 'primary', 
      city_name:  params[:city_name], 
      state_name: nil, 
      country_name: params[:country_name], 
      zipcode: params[:zip_code])
    puts "!!!! #{a.company_id}"
  end

  def update_address(params)
  end 
  
end
