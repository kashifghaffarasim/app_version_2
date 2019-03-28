class Admin::AdminController < ApplicationController

	def index
		@pools = Pool.all.length
		@customers =  User.with_any_role(:customer).length
		@users =  User.with_any_role(:admin, :user).length
		@vendors =  User.with_any_role(:vendor, :supplier, :other).length
		@invoices = Invoice.all.length
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
end
