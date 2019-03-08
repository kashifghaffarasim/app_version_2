module CommunicationsHelper

	def draft_emails
		draft = EmailNotification.where(sender_id: current_user.id,draft: true)
		return draft
	end
end
