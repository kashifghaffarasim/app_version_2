class RoutingsController < ApplicationController

	def index
		@vendors = User.where(company_id: current_user.try(:company_id)).where.not(:id => current_user.id).order(id: :asc).with_any_role(:vendor,:customer, :supplier, :admin, :user,:other)
	end
end

