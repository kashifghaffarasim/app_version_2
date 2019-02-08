class CommunicationsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index 
		@email_receives =  EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
		@email_views = EmailNotification.where(status: false)
	end 
	def sents
		@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page])
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

	def create
		user = User.find_by_email(params[:email_notification][:user_email])
		@email = EmailNotification.new(email_params)
		@email.sender_id = current_user.id 
		@email.receiver_id = user.id
		if @email.save
			EmailNotificationMailer.email_notification(@email).deliver
			flash[:success] = "Email Sent Successfully to #{params[:email_notification][:user_email]}" 
			@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
			@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page])
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

	end

	def destroy 
		@email =  EmailNotification.where(id: params[:id].split(','))
		if @email.delete_all 
			flash[:success] = "Email Successfully Destroy" 
			@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page])
			@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page])
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
		params.require(:email_notification).permit(:user_email,:subject,:body,:sender_id,:receiver_id,:attachment)
	end
end
