module PoolsHelper
  
  def get_plan()
    @plans = ServicePlan.where(company_id: current_user.try(:company_id))
  end
  
  def seviceitem
    
    if current_user.try(:company_id)
      item = Service.where(user_id: current_user.id ,service_type: "pool").last
    end
    
    return item
  end
  
  def chemicalitem
    ChamicalItem.where(company_id: current_user.try(:company_id), is_used: true)
  end
  
  def chemical_value(pool, chemical)
    poolitem = PoolChemicalItem.where(chamical_item_id: chemical.try(:id), pool_id: pool.try(:id))
    if !poolitem.blank?
      value = poolitem.last.try(:value)
    end
    return value
  end
  
  def get_value(value)
    isCorrect = false
    if !session[:item].blank?
      if value == 'chlorine'
        if session[:item][value].to_f <= 3 || session[:item][value].to_f  >= 7
          isCorrect = true
        end
      elsif value == 'ph'
        if session[:item][value].to_f <= 7.3 || session[:item][value].to_f  >= 7.6
          isCorrect = true
        end
      elsif value == 'slat'
        if session[:item][value].to_f <= 2400.0 || session[:item][value].to_f  >= 3400.0
          isCorrect = true
        end
      elsif value == 'alkalinity'
        if session[:item][value].to_f <= 90.0 || session[:item][value].to_f  >= 150.0
          isCorrect = true
        end
      else
        if session[:item][value].to_f <= 200.0 || session[:item][value].to_f  >= 400.0
          isCorrect = true
        end
      end
    end
    return isCorrect
  end
  
  def item_value(value)
    test = ""
    if !session[:item].blank?
      test = session[:item][value] 
    end
    return test
  end
  
end
