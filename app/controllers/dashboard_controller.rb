class DashboardController < ApplicationController

  def index
    
  end
  
	def profile
		@user = User.find_by_id(params[:username])
	end

end
