class Settings::PoolSettingsController < ApplicationController

	def index
		@pool_settings = current_user.company.pool_settings
	end

	def show 

	end
	def new

	end
	def create
		@pool_setting = PoolSetting.new(params_pool_setting)
		@pool_setting.company_id = current_user.company.id	
		if @pool_setting.save
			flash[:success] = "Your Pool Setting Successfully Create!"
			redirect_to settings_pool_settings_url
		else 
			flash[:danger] = "Your Pool Setting Did Not Create."
			redirect_to settings_pool_settings_url
		end 
	end

	def edit 
		@pool_setting = PoolSetting.find_by_id(params[:id])
	end 

	def update
		@pool_setting = PoolSetting.find_by_id(params[:id])
		if @pool_setting.update(params_pool_setting)
			flash[:success] = "Your Pool Setting Successfully Update!"
			redirect_to settings_pool_settings_url
		else
			flash[:danger] = "Your Pool Setting Did Not Update."
			render :edit
		end
	end

	def destroy 
		@pool_setting = PoolSetting.find_by_id(params[:id])
		if @pool_setting.destroy
			flash[:success] = "Your Pool Setting Successfully Delete!"
			redirect_to settings_pool_settings_url
		else
			flash[:danger] = "Your Pool Setting Did Not Delete."
			redirect_to settings_pool_settings_url
		end
	end 

	private

	def params_pool_setting
		params.require(:pool_setting).permit(:name, :company_id)
	end

end
