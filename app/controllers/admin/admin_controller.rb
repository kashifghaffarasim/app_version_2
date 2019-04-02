class Admin::AdminController < ApplicationController

	def index
		@pools = Pool.all.length
		@customers =  User.with_any_role(:customer).length
		@users =  User.with_any_role(:admin, :user).length
		@vendors =  User.with_any_role(:vendor, :supplier, :other).length
		@invoices = Invoice.all.length
	end 

	def show 
		@pool = Pool.find_by_id(params[:id])
	end

	def update 
		if params[:user]
			@user = User.find_by_id(params[:id])
			if @user.update(params_user)
				flash[:success] = "Customer Created Successfully updated!"
			else
				flash[:danger] = "Customer not update try again"
			end
		else
			@pool = Pool.find_by_id(params[:id])
			if @pool.update(params_pool)
				flash[:success] = "Pool Successfully updated!"
			else
				flash[:danger] = "Pool #{@pool.pool_name} not update try again"
			end
		end
		render "flash.js.erb"
	end

	def destroy
		@pool = Pool.find_by_id(params[:id])
		if @pool.destroy
			flash[:success] = "Pool Successfully destroy!"
		else
			flash[:danger] = "Pool #{@pool.pool_name} not destroy try again"
		end
		redirect_to pools_admin_admin_index_url
	end

	def user_destroy
		@user = User.find_by_id(params[:id])
		if @user.destroy
			flash[:success] = "Pool Successfully destroy!"
		else
			flash[:danger] = "Pool #{@pool.pool_name} not destroy try again"
		end
		if params[:page] == "vander"
			redirect_to vendors_admin_admin_index_url
		elsif params[:page] == "customer"
			redirect_to customers_admin_admin_index_url
		elsif params[:page] == "user"
			redirect_to users_admin_admin_index_url
		end		
	end

	def customers
		if params[:page]
			@customers = User.with_any_role(:customer).paginate(page: params[:page])
		else
			@customers = User.with_any_role(:customer).paginate(page: 1)
		end

	end
	def vendors
		if params[:page]
			@vendors = User.with_any_role(:vendor, :supplier, :other).paginate(page: params[:page])
			
		else
			@vendors = User.with_any_role(:vendor, :supplier, :other).paginate(page: 1)
		end
	end
	def users
		if params[:page]
			@users =  User.with_any_role(:admin, :user).paginate(page: params[:page])
		else
			@users =  User.with_any_role(:admin, :user).paginate(page: 1)
		end
	end 
	def pools
		if params[:page]
			@pools = Pool.all.paginate(page: params[:page])
		else
			@pools = Pool.all.paginate(page: 1)
		end
	end
	def invoices
		if params[:page]
			@invoices = Invoice.all.paginate(page: params[:page])
		else
			@invoices = Invoice.all.paginate(page: 1)
		end
	end
	private 

	def params_user
		params.require(:user).permit(:disable)
	end
	def params_pool
		params.require(:pool).permit(:disable)
	end

end
