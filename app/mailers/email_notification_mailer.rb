class EmailNotificationMailer < ApplicationMailer
	require "open-uri"
	def email_notification(email)
		@email = email
		if !email.attachment.blank?
			url = open("#{Rails.root}/public#{@email.attachment.url }")
			@attachments =  File.read(url)
			attachments["#{email.attachment_file_name}"] = @attachments
		end 
		mail(:to => email.user_email,:subject => email.subject)
	end
end

