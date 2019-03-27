class VendorsController < ApplicationController
	
  before_action :authenticate_user!
  before_action :get_vendor, only: [:show, :edit, :update, :destroy]
  
	def index
		@vendors = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:vendor, :supplier, :other)
  end
  
	def new
		@vendor  = User.new
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"vendors")

	end
  
	def show 
		@vendor  = User.find_by_id(params[:id])
	end
  
	def create
    params[:user][:password] = '12345678'
		@vendor  = User.new(user_params)
		@already = User.find_by_email(params[:user][:email])
		if @already.blank?
			if @vendor.save(validate: false)
      	@vendor.add_role params[:user][:role]
        vendor_address()
        begin
          @vendor.custom_fields(params[:custom_field],  @vendor.id)
        rescue
        end
				flash[:success] = "Vendor Created Successfully!"
				redirect_to vendors_url
			else 
				flash[:danger] = "Vendor not Saved try again"
				render :new
			end
		else
			flash[:danger] = "Email already used with other users. Please try with new email"
			render :new
		end
	end
  
  
	def edit
		@vendor = User.find_by_id(params[:id])
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"vendors")

	end 
  
	def update
		@vendor = User.find_by_id(params[:id])
		if @vendor.update(user_params)
#      @vendor.add_role params[:user][:role]
      vendor_address()
      begin
        @vendor.custom_fields(params[:custom_field],  @vendor.id)
      rescue
      end
			flash[:notice] = "Vendor updated!!!"
			redirect_to vendors_url
		else
			flash[:notice] = "Vendor not update try again"
			redirect_to vendors_url
		end
	end 
  
	def destroy
		@vendor = User.find_by_id(params[:id])
		if @vendor.destroy
			flash[:notice] = "Vendor Destroy!"
			redirect_to vendors_url
		else
			flash[:notice] = "Vendor did not Destroy!"
      redirect_to vendors_url
		end
	end
  
	private
  
	def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :source, :company_id ,:username, :phone_number, :mobile_number, :avatar)
	end
  
  def address_params
    params.require(:address).permit(:address_name, :city_name , :state_name , :country_name , :zipcode)
  end
  
  def get_vendor
    @vendor = User.find_by_id(params[:id])
  end
  
  def vendor_address
    if @vendor.address.blank?
      @address = Address.new(address_params)
      @address.user_id = @vendor.try(:id)
      if @address.save
      end
    else
      if @vendor.address.update(address_params)
           
      end
    end
  end
  
end
