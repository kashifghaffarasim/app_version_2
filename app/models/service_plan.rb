class ServicePlan < ApplicationRecord
  
  has_many :pool_service_items
  has_many :pools
  
  def service_create_or_update(plan, service_item_ids)
    
    plan.pool_service_items.update_all(is_used: false)
    service_item_ids.each do |item_id|
      already = PoolServiceItem.where(service_item_id: item_id, service_plan_id: plan.id)
      if already.blank?
        PoolServiceItem.create(is_used: true, service_item_id: item_id, service_plan_id: plan.id)
      else
        if already.last and already.last.update(is_used: true)
         
        end
      end
    end
    
  end
  
end
