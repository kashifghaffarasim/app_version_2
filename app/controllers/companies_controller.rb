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
    
  end
  
  def update
    
  end
  
  private
  
  def company_params
    params.require(:company).permit(:name)
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
