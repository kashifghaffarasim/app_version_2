class ServicesController < ApplicationController

	def index 

	end 

	def new 

	end 

	def create 
		params_service[:user_id] = current_user.id
		@pool_service = Service.new(params_service)
		@pool_service.save
		puts"#{request.env["HTTP_REFERER"]}"
		redirect_to(request.env["HTTP_REFERER"])

	end 
	
	def update
		
		@pool_service = Service.find_by_id(params[:id])
		if @pool_service.update(params_service)
		redirect_to(request.env["HTTP_REFERER"])
	end
puts"askdjjahsdh"
	end 
	def edit 

	end 
	def spa_service

		@pool_service = Service.where(user_id: current_user.id ,service_type: "spa").last
		@already = @pool_service
		puts"-=-=-=-=- #{@pool_service}"
		@pool_service = Service.new if @pool_service.blank?
	end
	def pool_service
		@pool_service = Service.where(user_id: current_user.id ,service_type: "pool").last
		@already = @pool_service
		@pool_service = Service.new if @pool_service.blank?

	end 
	private 

	def params_service
		params.require(:service).permit(:service_type, :ph_low, :ph_high, :ph_select, :ch_low, :ch_high, :ch_select, :combined_ch_low, :combined_ch_high,:combined_select,:alkalinity_low,:alkalinity_high,:alkalinity_select,:calcium_hardness_low,:calcium_hardness_high,:calcium_select,:stabilizer_low,:stabilizer_high,:stabilizer_select,:salt_low,:salt_high,:salt_select,:dissolved_soild_low,:dissolved_soild_high,:dissolved_select,:saturation_index_low,:saturation_index_high,:saturation_select,:user_id)
	end
end
