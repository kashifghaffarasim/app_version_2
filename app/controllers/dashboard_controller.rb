class DashboardController < ApplicationController

	def profile
		@user = User.find_by_id(params[:username])
	end

end
