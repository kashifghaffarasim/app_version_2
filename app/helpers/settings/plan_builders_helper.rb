module Settings::PlanBuildersHelper
  
  def get_status(item)

    already = PoolServiceItem.where(service_item_id: item.try(:id),service_plan_id: @service_plan.try(:id), is_used: true)
    if !already.blank?
      value = true
    else
      value = false
    end
    return value
    
  end
end
