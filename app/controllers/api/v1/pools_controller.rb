class Api::V1::PoolsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :get_pool, only: [:show, :edit, :update, :destroy, :service_plan, :save_results, :test_results]
	require 'open_weather'
	def  index 
		@user = User.find_by_id(params[:user_id])
		@pools = Pool.where(company_id: @user.try(:company_id)).order(id: :asc)
	end 

	def show

	end

	def new 
		@pool = Pool.new
	end 

	def create
		@pool = Pool.new(pool_params)
		@user = User.find_by_id(params[:user_id])
		@pool.company_id = @user.company_id
		if @pool.save 
			pool_address()
			render :json=> {
				:success => "Pool created."
			},:status => 400
		else
			render :json=> {
				:error => "Pool did not created. Please try again."
			},:status => 400
		end 

	end 
	def update 
		@pool = Pool.find_by_id(params[:id])
		if @pool.update(pool_params) 
			pool_address()
			render :json=> {
				:success => "Pool updated."
			},:status => 400
		else
			render :json=> {
				:error => "Pool did not update. Please try again."
			},:status => 400
		end 
	end

	def destroy
		@pool = Pool.find_by_id(params[:id])
		if @pool.destroy 
			render :json=> {
				:success => "Pool destroy."
			},:status => 400
		else
			render :json=> {
				:error => "Pool did not destroy. Please try again."
			},:status => 400
		end 
	end 

	private 

	# def parse_image
	# 	image = Paperclip.io_adapters.for(image_base)
	# 	image.original_filename = "file.jpg"
	# 	self.picture = image
	# end
	def pool_params
		params.require(:pool).permit(
			:pool_name ,:pool_description ,:pool_type , :pool_volume , :user_id,
			:pool_volume2, :pool_gate_code, :pool_source_type, :pool_lifeguards,
			:pool_activity)
	end 

	def data_params
		params.require(:pool_datum).permit(:pool_type,:shape,:type_manufacturer,:type_model, :type_serial_number, :type_color, :type_voltage, :surface_material, :equip_pump_brand, :equip_model, :equip_horsepower, :equip_service_factor, :equip_voltage, :filter_brand, :filter_model, :filter_type, :filter_cartridge, :cartridge_size, :cartridge_part, :cartridge_date, :filter_sand_model, :filter_sand_size, :filter_date_replaced, :filter_de, :heater_brand, :heater_model, :heater_size, :heater_type, :time_clock_brand, :time_clock_model, :time_clock_voltage)
	end

	def address_params
		params.require(:address).permit(:address_name, :city_name , :address_name2 , :state_name , :country_name , :zipcode)
	end

	def get_pool
		@pool = Pool.find_by_id(params[:id])
	end 

	def pool_address
		if @pool.address.blank?
			@address = Address.new(address_params)
			@address.pool_id = @pool.try(:id)
			if @address.save
			end
		else
			if @pool.address.update(address_params)

			end
		end
	end


end
