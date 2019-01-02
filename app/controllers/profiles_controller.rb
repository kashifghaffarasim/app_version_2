class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_user, only: [:update, :index]

  def index
   
  end
  
  def show

  end

  def edit
   
  end
  
  def update
    if @user and @user.update(user_params)
      if @user.address.blank?
        @address = Address.new(address_params)
        @address.user_id = @user.try(:id)
        if @address.save
        end
      else
        if @user.address.update(address_params)
           
        end
      end
    end
    redirect_to profiles_url
  end
  
  
  
  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :phone_number, :mobile_number, :avatar)
  end
  
  def address_params
    params.require(:address).permit(:address_name, :city_name , :state_name , :country_name , :zipcode)
  end
  
  def get_user
    if params[:id].blank?
      @user = User.find_by_id(current_user.try(:id))
    else
      @user = User.find_by_id(current_user.try(:id))
    end
  end
  
end
