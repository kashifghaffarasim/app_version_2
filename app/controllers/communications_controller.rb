class CommunicationsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index 
		if params[:id].blank?
			@email_receives =  EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
			@email_views = EmailNotification.where(status: false)
		else
			@email= EmailNotification.find_by_id(params[:id])
			@email.update(status:  true)
		end
	end 
	def sents
		@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page]).where.not(draft: true)
	end

	def receives
		@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
	end
	def new 
		@email = EmailNotification.new
	end 
	def attachment
		@file = EmailNotification.find(params[:id])
		send_file @file.attachment.path
	end
	def show
		@email= EmailNotification.find_by_id(params[:id])
		@email.update(status:  true)
	end

	def drafts
		@draft_emails = EmailNotification.where(sender_id: current_user.id,draft: true).paginate(:page => params[:page])

	end

	def create
		user = User.find_by_email(params[:email_notification][:user_email])
		@email = EmailNotification.new(email_params)
		@email.sender_id = current_user.id 
		@email.receiver_id = user.id
		if @email.save
			if @email.draft
				flash[:success] = "Email Sent Successfully save to draft" 
			else 
				EmailNotificationMailer.email_notification(@email).deliver
				flash[:success] = "Email Sent Successfully to #{params[:email_notification][:user_email]}" 
			end
			@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
			@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page]).where.not(draft: true)

			if @email.receiver_id == current_user.id 
				render "receives.js.erb"
			else	
				render "sents.js.erb"
			end 
		else
			flash[:danger] = "Email Not Sent to #{params[:email_notification][:user_email]} Try Again"
			render "new.js.erb"	
		end 
	end

	def edit 
		@email =  EmailNotification.find_by_id(params[:id].split(','))
	end

	def update
		@email =  EmailNotification.find_by_id(params[:id].split(','))
		#@email.draft = false
		if @email.update(email_params)
			if @email.draft
				flash[:success] = "Email Sent Successfully save to draft" 
			else 
				EmailNotificationMailer.email_notification(@email).deliver
				flash[:success] = "Email Sent Successfully to #{params[:email_notification][:user_email]}" 
			end
			@draft_emails = EmailNotification.where(sender_id: current_user.id,draft: true).paginate(:page => params[:page])
			render "drafts.js.erb"
		else
			flash[:danger] = "Email Not Sent to #{params[:email_notification][:user_email]} Try Again"
			render "drafts.js.erb"
		end

	end

	def destroy 
		@email =  EmailNotification.where(id: params[:id].split(','))
		if @email.delete_all 
			flash[:success] = "Email Successfully Destroy" 
			@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
			@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page]).where.not(draft: true)
			if params[:status] != "sent"
				render "receives.js.erb"
			else
				render "sents.js.erb"
			end
		else
			flash[:danger] = "Email Not Destroy Try Again !"
			if params[:status] != "sent"
				render "receives.js.erb"
			else
				render "sents.js.erb"
			end
		end 
	end

	private 

	def email_params
		params.require(:email_notification).permit(:user_email,:subject,:body,:sender_id,:receiver_id,:attachment,:draft)
	end
end
