module ApplicationHelper
	
	def unread_receive
		receive = EmailNotification.where(receiver_id: current_user.id,status: false)
		
    return receive
	end
	def unread_sent
		sent = EmailNotification.where(sender_id: current_user.id)
		return sent
	end
	def unread_receive_sms
		receive = Sm.where(receiver_id: current_user.id,status: false)
		return receive
	end
	def unread_sent_sms
		sent = Sm.where(sender_id: current_user.id)
		return sent
	end

  def vander 
    vendors = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:vendor, :supplier, :other)
    return vendors
  end
  
 

  def customer
    customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
    return customers
  end

  def team_member
    team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
    return team_members
  end

	def total_user
		total_user = team_member().length + vander().length + customer().length
		return total_user
	end
  
  def timing
    array = [
      "01:00 AM", "02:00 AM", "03:00 AM",
      "04:00 AM", "05:00 AM", "06:00 AM",
      "07:00 AM", "08:00 AM", "09:00 AM",
      "10:00 AM", "11:00 AM", "12:00 AM",
      "01:00 PM", "02:00 PM", "03:00 PM",
      "04:00 PM", "05:00 PM", "06:00 PM",
      "07:00 PM", "08:00 PM", "09:00 PM",
      "10:00 PM", "11:00 PM", "12:00 PM",
    ]
  end
end
