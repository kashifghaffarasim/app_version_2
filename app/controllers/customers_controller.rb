class CustomersController < ApplicationController
  #validates :email, :presence => true, :email => true
  before_action :authenticate_user!
  before_action :get_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
  end
  
  def new
    @customer = User.new
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"customers")

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

  def generate_csv 
    require 'csv'
    @customer = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
    csv_string = CSV.generate do |csv|
      csv << %w{first_name last_name address_name address_type city_name state_name country_name zipcode username email company_name mobile_number phone_number}
      @customer.each do |customer| 
        csv << [customer.try(:first_name), customer.try(:last_name),customer.address.try(:address_name),customer.address.try(:address_type),customer.address.try(:city_name),customer.address.try(:state_name),customer.address.try(:country_name),customer.address.try(:zipcode),customer.try(:username),customer.try(:email),customer.try(:mobile_number),customer.try(:phone_number)]
      end
    end
    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=customer.csv"
  end
  def import_csv
      require 'csv'
    if !params["file"].blank?
      csv_text = File.read(params["file"].tempfile)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |customer|
        if User.find_by_email(customer["email"]).blank?
          @customer = User.new({:first_name => customer["first_name"],:last_name => customer["last_name"],:email => customer["email"] ,:username => customer["username"],:mobile_number => customer["mobile_number"],:phone_number=> customer["phone_number"]})
       #  @customer.status = "customer"
        @customer.company_id = current_user.try(:company_id)
          if @customer.save(:validate => false)
            @customer.add_role :customer
            address_1(customer)
            #flash[:success] = "customer Successfully Import!"
            #redirect_to customers_url
          else
            #flash[:danger] = "customer not Import try again"
            #redirect_to customers_url
          end
        else
          #flash[:danger] = "Email Already Taken by other user."
            #redirect_to customers_url
        end
      end
    else
      flash[:danger] = "Please Select CSV File......!!!"
      redirect_to customers_url
    end
      redirect_to customers_url

  end
  def list_customers
    @customers =  User.where("company_id = ? AND (first_name LIKE ? OR last_name LIKE ?)", params[:company_id], "%#{params[:name]}%", "%#{params[:name]}%").order(id: :asc).with_any_role(:customer)
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
  def address_1(customer) 
    if @customer.address.blank?
      @address = Address.new({:address_name => customer["address_name"],:city_name => customer["city_name"],:state_name => customer["state_name"],:country_name => customer["country_name"],:zipcode => customer["zipcode"]})
      @address.user_id = @customer.try(:id)
      if @address.save
        puts"nananna" ,@address.inspect
      end
    else

    end
  end
end
