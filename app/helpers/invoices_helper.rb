module InvoicesHelper
  
  def get_street_name(job)
    if job.pool &&  job.pool.address
      name = job.pool.address.try(:address_name)
    end
    return name
  end
  
  def get_city_name(job)
    if job.pool && job.pool.address
      name =  job.pool.address.try(:city_name)
    end
    return name
  end
  
  def get_country_name(job)
    if job.pool && job.pool.address
      name =  job.pool.address.try(:country_name)
    end
    return name
  end
  
end
