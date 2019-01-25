class EmailNotificationMailer < ApplicationMailer

	def email_notification(email)
		require "open-uri"
		@email = email
		if !email.attachment.blank?
			url = open("#{Rails.root}/public#{@email.attachment.url }")
			puts"nannan ",url.inspect
			@attachments =  File.read(url)
			attachments["#{email.attachment_file_name}"] = @attachments
		end 
		puts"hahahha #{email.subject}"
		mail(:to => email.user_email,:subject => email.subject)
	end
end

