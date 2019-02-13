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
