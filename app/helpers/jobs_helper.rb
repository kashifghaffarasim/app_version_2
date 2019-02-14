module JobsHelper
  
  
  def visti_status(visit)
    if visit.status == 'Pending'
      array = ["Pending", "In Progress", "Completed"]
    elsif  visit.status == 'In Progress'
      array = ["In Progress","Complete"]
    else
      array = ["Complete"]
    end
    return array
  end
  
  
  
  
end
