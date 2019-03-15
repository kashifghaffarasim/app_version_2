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
  
  def customer_name_invoice(inovice)
    name = ""
    if inovice
      job = inovice.job
      if job
         user = User.find_by_id(job.try(:customer_id))
         name = user.try(:fullname)
      end
    end
    return name 
  end
  
end
