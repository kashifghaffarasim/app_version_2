class Plan < ApplicationRecord
	
	belongs_to :user , optional: true
	attr_accessor :stripeToken

	def pricing(plan,customer, source)
		if self.plan_name == "solo"
			@plan = plan.update(plan_price: "19.95")
		elsif self.plan_name == "team"
			@plan = plan.update(plan_price: "29.95")
		elsif self.plan_name == "business"
			@plan = plan.update(plan_price: "49.95")
		end
		save_with_payment(plan,customer,source)
	end



	def save_with_payment(plan,customer,source)
		begin
			Stripe::Charge.create(
				:amount => (plan.plan_price * 100).to_i,
				:currency => 'usd',
				:customer => customer.id,
				:description => 'Example charge custom form',
				#:card      => customer.id
				)
			#redirect_to plans_url
		rescue Stripe::CardError => e
			flash[:error] = e.message
			#redirect_to plans_url
		end
	end
end 