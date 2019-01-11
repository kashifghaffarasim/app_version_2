class Plan < ApplicationRecord
	
	belongs_to :user , optional: true

	def pricing(plan)
		if self.plan_name == "solo"
			@plan = plan.update(plan_price: "19.95")
		elsif self.plan_name == "team"
			@plan = plan.update(plan_price: "29.95")
		elsif self.plan_name == "business"
			@plan = plan.update(plan_price: "49.95")
		end
	end
end
