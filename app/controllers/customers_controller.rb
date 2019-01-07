class CustomersController < ApplicationController
  #validates :email, :presence => true, :email => true
  before_action :authenticate_user!
  before_action :get_customer, only: [:show, :edit, :update, :destroy]


  def index
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
  end
  def new
    @customer = User.new
  end

  def show 
    @customer = User.find_by_id(params[:id])
  end

  def create

    params[:user][:password] = '12345678'
    @customer  = User.new(user_params)
    @already = User.find_by_email(params[:user][:email])
    if @already.blank?
      if @customer.save(validate: false)
        @customer.add_role :customer
        customer_address()
        flash[:success] = "Customer Created Successfully!"
        redirect_to customers_url
      else 
        flash[:danger] = "Customer not Saved try again"
        render :new
      end
    else
      flash[:danger] = "Email already used with other users. Please try with new email"
      render :new
    end
	

  end
  def edit
    @customer = User.find_by_id(params[:id])
  end 
  def update
    @customer = User.find_by_id(params[:id])
    if @customer.update(user_params)
      @customer.add_role :customer
      customer_address()
      flash[:notice] = "Customer updated!!!"
      redirect_to customers_url
    else
      flash[:notice] = "Customer not update try again"
      redirect_to customers_url

    end
  end 
  def destroy
    @customer = User.find_by_id(params[:id])
    if @customer.destroy
      flash[:notice] = "Customer Destroy!"
      redirect_to customers_url
    else
      flash[:notice] = "Customer did not Destroy!"
      redirect_to customers_url
    end
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :company_id ,:source, :username, :phone_number, :mobile_number, :avatar)
	end
  
  def address_params
    params.require(:address).permit(:address_name, :city_name , :address_name2 , :state_name , :country_name , :zipcode)
  end
  
  def get_customer
    @customer = User.find_by_id(params[:id])
  end
  
  def customer_address
    if @customer.address.blank?
      @address = Address.new(address_params)
      @address.user_id = @customer.try(:id)
      if @address.save
      end
    else
      if @customer.address.update(address_params)
           
      end
    end
  end
end
