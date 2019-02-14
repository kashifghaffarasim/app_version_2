class SmsController < ApplicationController
	require 'twilio-ruby'
	layout false, only: [:new_sms]
	include ActionController::Live


	def index
		if params[:id].blank?
			@sms_receives =  Sm.where(receiver_id: current_user.id).paginate(:page => params[:page])
		else
			@sms = Sm.find_by_id(params[:id])
			@sms.update(status:  true)
		end
	end 
	def sents
		@sms_sents = Sm.where(sender_id: current_user.id).paginate(:page => params[:page])
	end

	def receives
		@sms_receives = Sm.where(receiver_id: current_user.id).paginate(:page => params[:page])
	end
	def show
		@sms = Sm.find_by_id(params[:id])
		@sms.update(status:  true)
	end
	def new
		@sms = Sm.new
	end 

	

	def create
		@user = User.find_by_id(params[:sm][:user_number])
		@sms = Sm.new(params_sms)
		@sms.sender_id = current_user.id
		@sms.receiver_id = @user.id
		@sms.user_number = @user.mobile_number
		if @sms.save 
			session[:sms_id] = @sms.id
			flash[:success] = "Sms Sent Successfully to #{@user.mobile_number}" 

			#@twilio_client = Twilio::REST::Client.new
			#begin
			#	twilio = @twilio_client.messages.create(
			#		from: '+14159341234',
			#		to: params[:user_number],
			#		body: params[:body]
			#		)  
			#	puts"asas #{twilio}"
			#	puts twilio.to

			#rescue Twilio::REST::RestError => error
			#	@error = error
			#	puts

		#	end
		@sms_receives = Sm.where(receiver_id: current_user.id).paginate(:page => params[:page])
		@sms_sents = Sm.where(sender_id: current_user.id).paginate(:page => params[:page])
		if @sms.receiver_id == current_user.id 
			render "receives.js.erb"
		else	
			render "sents.js.erb"
		end 
	else
		flash[:danger] = "Sms Not Sent to #{@user.mobile_number} Try Again"
		render "new.js.erb"	
	end
end 
def destroy 
	@sms =  Sm.where(id: params[:id].split(','))
	if @sms.delete_all 
		flash[:success] = "Email Successfully Destroy" 
		@sms_receives = Sm.where(receiver_id: current_user.id).paginate(:page => params[:page])
		@sms_sents = Sm.where(sender_id: current_user.id).paginate(:page => params[:page])
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

def params_sms
	params.require(:sm).permit(:user_number,:body,:sender_id,:receiver_id,:status)
end


end
