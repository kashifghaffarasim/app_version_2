class CommunicationsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index 
		@email = EmailNotification.new
		@email_views = EmailNotification.where(status: false)
	end 
	def sents
		@email_sents = EmailNotification.where(sender_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
	end

	def receive
		@email_receives = EmailNotification.where(receiver_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
	end
	def new 

	end 
	def attachment
		@file = EmailNotification.find(params[:id])
		send_file @file.attachment.path
	end
	def show
		puts"#{params[:status]}"
		@email= EmailNotification.find_by_id(params[:id])
	end

	def create
		user = User.find_by_email(params[:email_notification][:user_email])
		puts"sjjjjjjjjjjj #{params[:email_notification][:user_email]}"
		@email = EmailNotification.new(email_params)
		@email.sender_id = current_user.id 
		@email.receiver_id = user.id
		if @email.save
			EmailNotificationMailer.email_notification(@email).deliver
			flash[:success] = "Email Sent Successfully to #{params[:email_notification][:user_email]}" 
      render "flash.js.erb"
			
		else
			flash[:danger] = "Email Not Sent to #{params[:email_notification][:user_email]} Try Again"
		  render "flash.js.erb"
		end 
	end

	def edit 

	end

	def destroy 

	end

	private 

	def email_params
		params.require(:email_notification).permit(:user_email,:subject,:body,:sender_id,:receiver_id,:attachment)
	end
end
