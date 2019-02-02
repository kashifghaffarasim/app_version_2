module ApplicationHelper
	
	def unread_receive
		receive = EmailNotification.where(receiver_id: current_user.id,status: false).length
		return receive
	end
	def unread_sent
		sent = EmailNotification.where(sender_id: current_user.id).length
		return sent
	end

end
