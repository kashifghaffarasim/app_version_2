class PlansController < ApplicationController

	def index
		@plan = Plan.find_by_id(current_user.plan_id)

	end 

	def create
		if current_user.plan_id.blank?
			@plan = Plan.new(params_plan)
			if @plan.save
				@plan.pricing(@plan)
				plan_id_to_user()
				flash[:success] = "Your Plan Successfully Create!"
				redirect_to plans_url
			else
				redirect_to plans_url
				 flash[:danger] = "Your Plan not Saved try again"
			end
		else
			@plan = Plan.find_by_id(current_user.plan_id)
			if @plan.update(params_plan)
				@plan.pricing(@plan)
				flash[:success] = "Your Plan Successfully Update!"
				redirect_to plans_url
		
			else
				flash[:danger] = "Your Plan not Update try again"
				redirect_to plans_url
			end
		end

      
       
	end 

	private

	def params_plan
		params.require(:plan).permit(:plan_name,:plan_price)
	end

	def plan_id_to_user
		current_user.update(plan_id: @plan.try(:id))
	end
end
