class Settings::NotificationOptionsController < ApplicationController

	def index

	end
	def new
		@notification_option = NotificationOption.new
	end
	def create
		@already = []
		current_user.company.notification_options.each {|option| @already << option if option.message_type == "customer" or "team_member"  }
		if @already.blank?
			@notification_option = NotificationOption.new(params_notification_option)
			@notification_option.company_id = current_user.company.id	

			if @notification_option.save
				flash[:success] = "Your Notification Option Setting Successfully Create!"
				redirect_to settings_notification_options_url
			else 
				flash[:danger] = "Your Notification Option Setting Did Not Create."
				redirect_to settings_notification_options_url
			end 
		else
			flash[:danger] = "Your Notification Option Setting Already Found For Selected Module."
			render :new 
		end
	end 
	def show

	end

	def edit 
		@notification_option = NotificationOption.find_by_id(params[:id])
	end
	def update
		@notification_option = NotificationOption.find_by_id(params[:id])
		if @notification_option.update(params_notification_option)
			flash[:success] = "Your Notification Option Setting Successfully Update!"
			redirect_to settings_notification_options_url
		else 
			flash[:danger] = "Your Notification Option Setting Did Not Update."
			render :edit
		end 
	end
	def destroy 
		@notification_option = NotificationOption.find_by_id(params[:id])
		if @notification_option.destroy
			flash[:success] = "Your Notification Option Setting Successfully Destroy!"
			redirect_to settings_notification_options_url
		else 
			flash[:danger] = "Your Notification Option Setting Did Not Destroy."
			redirect_to settings_notification_options_url
		end 
	end
	private

	def params_notification_option
		params.require(:notification_option).permit(:subject,:message_type,:message_content,:company_id)
	end


end
