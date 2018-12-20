class CustomersController < ApplicationController
#validates :email, :presence => true, :email => true



def index
	@customers = User.with_role(:customer)
end
def new
	@customers = User.new
end

def show 
	@customers = User.find_by_id(params[:id])
end

def create
	@customers = User.new(user_params)
	@already = User.find_by_email(params[:user][:email])
	if @already.blank?
		if @customers.save(validate: false)
			@customers.add_role :customer
			puts"hahahahah"
			flash[:notice] = "Customer Created!!!"
			redirect_to customers_url
		else 
			flash[:notice] = "Customer not Saved try again"
			redirect_to customers_url
			
		end
	else
		flash[:notice] = "This email already used for Customer"
		redirect_to customers_url
	end
	

end
def edit
	@customers = User.find_by_id(params[:id])
end 
def update
	@customers = User.find_by_id(params[:id])
	if @customers.update(user_params)
		flash[:notice] = "Customer updated!!!"

		redirect_to customers_url

	else
		flash[:notice] = "Customer not updated try again"

		redirect_to customers_url


	end
end 
def destroy
	@customers = User.find_by_id(params[:id])
	if @customers.destroy
		flash[:notice] = "Customer Destroy"

		redirect_to customers_url

	else
		flash[:notice] = "Customer not Destroy try again"

		redirect_to customers_url
	end
end
private
def user_params
	params.require(:user).permit(:first_name, :last_name, :email)
end
end
