class Api::V1::VendorsController < ApplicationController
	before_action :get_user 
	def index
		@vendors = User.where(company_id: @current_user.try(:company_id)).order(id: :asc).with_any_role(:vendor, :supplier, :other)
	end
	private 
	def get_user
		@current_user = User.find_by_id(params[:user_id])
	
	end

end
