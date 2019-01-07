class CompaniesController < ApplicationController
  layout 'xtream-front', only: [:index, :create]
  
  before_action :authenticate_user! , only: [:edit, :update, :show]
  
  def index
    if session[:user].blank?
      redirect_to new_user_url
    end
  end
  
  def create
    begin
      @company = Company.new(company_params)
      if @company.save
        @company.save_address(params[:company])
        save_user(@company)
      end
      flash[:success] = "Welcome to PoolPath. Let begin with your company"
      redirect_to dashboard_url
    rescue
      flash[:danger] = "Something went wrong with your account. Please try again"
      redirect_to new_user_url
    end

  end

  def show
    @company = Company.find_by_id(params[:id])
  end
  
  def edit
    @company = Company.find_by_id(params[:id])
  end
  
  def update
    @company = Company.find_by_id(params[:id])
    if @company.update(company_params)
      address_update()
      flash[:success] = "settings update!"
    else
      flash[:error] = "settings not update!"
      
    end
    redirect_back(fallback_location: root_path)
  end
  
  def edit_address
    @address = Address.find_by_id(params[:id])
  end
  
  def update_address
    @address = Address.find_by_id(params[:id])
    if @address.update(address_params)
      flash[:success] = "settings update!"
    else
      flash[:error] = "settings not update!"
    end
    redirect_to settings_url
  end

  private

  def company_params
    params.require(:company).permit(:name, :latitude, :logitude, :phone, :email, :website, :start_week, :avatar)
  end
  
  def address_params
    params.require(:address).permit(:address_name, :state_name ,:city_name,:country_name,:zipcode)
  end

  def address_update
    if @company
      if @company.address.blank?
        @address = Address.new(address_params)
        @address.company_id = @company.try(:id)
        if @address.save
        end
      else
        if @company.address.update(address_params)
           
        end
      end
    end
  end
  
  def save_user(company)
    @user =  User.new(:first_name => session[:user]['first_name'], 
      :last_name => session[:user]['last_name'], 
      :email =>  session[:user]['email'], 
      :password => session[:user]['password'], company_id: company.try(:id))
    if @user.save
      @user.add_role :owner
      sign_in @user
    end
  end
end
