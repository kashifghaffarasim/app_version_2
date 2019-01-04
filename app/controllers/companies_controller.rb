class CompaniesController < ApplicationController
  layout 'xtream-front', only: [:index, :create]
  
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
  
  def edit
    puts"JJJJJ"
    @company = Company.find_by_id(params[:id])
    
  end
  
  def update
    @company = Company.find_by_id(params[:id])
    if @company.update(company_params)
      flash[:notice] = "settings update!"
      #redirect_to vendors_url
    else
      flash[:notice] = "settings not update!"
      #redirect_to vendors_url
    end
  end
  def edit_address
    @address = Address.find_by_id(params[:id])
  end
  def update_address
    @address = Address.find_by_id(params[:id])
    if @address.update(address_params)
      flash[:notice] = "settings update!"
      #redirect_to vendors_url
    else
      flash[:notice] = "settings not update!"
      #redirect_to vendors_url
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
  def address_params
    params.require(:address).permit(:address_name,:city_name,:country_name,:zipcode)
  end
  def company_address
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
