class Company < ApplicationRecord
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  has_one :address
  has_many :users
  has_many :pool_settings
  has_many :notification_options
  has_many :chamical_items
  
  after_create :create_chemical_item
  
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
  
  def create_chemical_item
    
    @chemicals = ["Liquid chlorine gal", "Di chlor ib" , "Tri chlor ib" , "Muriatic acid gal",
      "Dry muriatic acid lb", "Bromine tans", "Soda ash lb", "Sodium bicarbonate lb",
      "Salt bags", "Water clarifier oz", "Algacide oz", "Phosphate remover"
    ]
    @chemicals.each do |i|
      begin
        ChamicalItem.create(name: i, company_id: self.id, is_used: false )
      rescue => e

      end
    end
    
  end
  
 
end
