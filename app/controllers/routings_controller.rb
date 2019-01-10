class RoutingsController < ApplicationController

	def index
		@vendors = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:vendor, :supplier, :other)
	end 
end
