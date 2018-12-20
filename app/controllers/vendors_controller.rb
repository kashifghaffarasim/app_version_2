class VendorsController < ApplicationController
	
	def index
		@vendors = User.with_role(:vendor)
	end
	def new
		@vendors  = User.new
	end
	def show 
		@vendors  = User.find_by_id(params[:id])
	end
	def create

		@vendors  = User.new(user_params)
		@already = User.find_by_email(params[:user][:email])

		if @already.blank?
			if @vendors.save(validate: false)
				@vendors.add_role :vendor
				puts"hahahahah"
				flash[:notice] = "Vendor Created!"
				redirect_to vendors_url
			else 
				flash[:notice] = "Vendor not Saved try again"
				redirect_to vendors_url
			end
		else
			flash[:notice] = "This email already used for vendor"
			redirect_to vendors_url
		end

	end
	def edit
		@vendors = User.find_by_id(params[:id])
	end 
	def update
		@vendors = User.find_by_id(params[:id])
		if @vendors.update(user_params)
			flash[:notice] = "Vendor updated!!!"
			redirect_to vendors_url
		else
			flash[:notice] = "Vendor not update try again"
			redirect_to vendors_url
		end
	end 
	def destroy
		@vendors = User.find_by_id(params[:id])
		if @vendors.destroy
			flash[:notice] = "Vendor Destroy!"
			redirect_to vendors_url
		else
			flash[:notice] = "Vendor did not Destroy!"
		redirect_to vendors_url
		end
	end
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email)
	end
end
