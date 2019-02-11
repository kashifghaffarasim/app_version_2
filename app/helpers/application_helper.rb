module ApplicationHelper
	
	def unread_receive
		receive = EmailNotification.where(receiver_id: current_user.id,status: false).length
		return receive
	end
	def unread_sent
		sent = EmailNotification.where(sender_id: current_user.id).length
		return sent
	end
	def unread_receive_sms
		receive = Sm.where(receiver_id: current_user.id,status: false).length
		return receive
	end
	def unread_sent_sms
		sent = Sm.where(sender_id: current_user.id).length
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
end
