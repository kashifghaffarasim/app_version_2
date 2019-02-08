class PlansController < ApplicationController

	def index
		@plan = Plan.find_by_id(current_user.plan_id)

	end 

	def new 
	end 

	def create
		@customer = Stripe::Customer.create(
			:email => params[:email],
			:source  => params[:stripeToken]
			)
		if current_user.plan_id.blank?
			@plan = Plan.new(params_plan)
			if @plan.save_with_payment
				@plan.pricing(@plan,@customer,params[:stripeToken])
				plan_id_to_user()
				flash[:success] = "Your Plan Successfully Create!"
			else
				flash[:danger] = "Your Plan not Saved try again"
			end
		else
			@plan = Plan.find_by_id(current_user.plan_id)
			if @plan.update(params_plan)
				@plan.pricing(@plan,@customer, params[:stripeToken])
				flash[:success] = "Your Plan Successfully Update!"
			else
				flash[:danger] = "Your Plan not Update try again"
			end
		end
		render "index"
	end
	private

	def params_plan
		params.require(:plan).permit(:plan_name,:plan_price)
	end

	def plan_id_to_user
		current_user.update(plan_id: @plan.try(:id))
	end
end
