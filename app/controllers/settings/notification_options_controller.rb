class Settings::NotificationOptionsController < ApplicationController

	def index

	end
	def new
		@notification_option = NotificationOption.new
	end
	def create
		@notification_option = NotificationOption.new(params_notification_option)
		@notification_option.company_id = current_user.company.id	
		if @notification_option.save
			flash[:success] = "Your Notification Option Setting Successfully Create!"
			redirect_to settings_pool_settings_url
		else 
			flash[:danger] = "Your Notification Option Setting Did Not Create."
			redirect_to settings_pool_settings_url
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
			redirect_to settings_pool_settings_url
		else 
			flash[:danger] = "Your Notification Option Setting Did Not Update."
			redirect_to settings_pool_settings_url
		end 
	end
	def destroy 
		@notification_option = NotificationOption.find_by_id(params[:id])
		if @notification_option.destroy
			flash[:success] = "Your Notification Option Setting Successfully Destroy!"
			redirect_to settings_pool_settings_url
		else 
			flash[:danger] = "Your Notification Option Setting Did Not Destroy."
			redirect_to settings_pool_settings_url
		end 
	end
	private

	def params_notification_option
		params.require(:notification_option).permit(:subject,:message_type,:message_content,:company_id)
	end


end
