class Api::V1::CustomersController < ApplicationController
	before_action :get_user 
	def index
		@customers =  User.where(company_id: @current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
	end

	private

	def get_user
		@current_user = User.find_by_id(params[:user_id])
	end

end
