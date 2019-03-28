class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  rolify
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/users/5.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  belongs_to :company , optional: true
  has_many :pools
  has_one :address
  has_one :plans
  has_many :user_notifications
  self.per_page = 30
  def fullname
    if  self.try(:first_name)
      if !self.last_name.blank?
        name = self.try(:first_name).capitalize + " " +  self.try(:last_name).capitalize
      else
        name = self.try(:first_name).capitalize
      end
    else
      name = ""
    end
    return name
  end
  
  
  def custom_fields(params, id)
    if params
      if params[:default] && id
        params[:default].each do |custom|
          list =  custom[1]
          if list
            already = CustomAttriValue.where(model_id: id, custom_field_id: list[:id])
            if already.blank?
              CustomAttriValue.create(value: list[:value], model_id: id, custom_field_id: list[:id])
            else
              custom_value = already.last
              if custom_value &&  custom_value.update(value: list[:value])
              end
            end
          end
        end
      end
    end
  end
  
end
