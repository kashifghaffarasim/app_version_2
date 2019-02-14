module EstimatesHelper
  
  def customer_name(job)
    user = User.find_by_id(job.try(:customer_id))
    return user.try(:fullname)
  end
  
  def getTaxAmount(estimate)
    if estimate.tax && estimate.tax
      (estimate.sub_total * estimate.tax)/100
    else
      0
    end
  end
  
end
