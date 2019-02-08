module EstimatesHelper
  
  def customer_name(job)
    user = User.find_by_id(job.try(:customer_id))
    return user.try(:fullname)
  end
  
  def getTaxAmount(estimate)
   (estimate.sub_total * estimate.tax)/100
  end
end
