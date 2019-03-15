module PoolsHelper
  
  def get_plan()
    @plans = ServicePlan.where(company_id: current_user.try(:company_id))
  end
end
