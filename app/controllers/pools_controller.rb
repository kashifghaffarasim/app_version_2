class PoolsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :get_pool, only: [:show, :edit, :update, :destroy]
  require 'open_weather'
  def index
    @pools = Pool.where(company_id: current_user.try(:company_id)).order(id: :asc)
  end
  def measure_pool

    property = Pool.find_by_id(params[:id])
    puts"-=------------ #{property.address.address_name}"
    options = { units: "metric", APPID: WEATHER_APPID }
    res = OpenWeather::Current.city("#{property.address.address_name + ","+property.address.city_name}",options) rescue ""
    puts"-========================= #{res}"
    @lat = res["coord"]["lat"]
    puts"-=-=-= #{@lat}"
    @lon = res["coord"]["lon"]
  end
  def map
    @pool = Pool.find_by_id(params[:id]).address
  end
  
  def map_address
    @address = Address.find_by_id(params[:id])
    if @address.update(address_params)
      flash[:notice] = "Pool Address Updated!"
      redirect_to map_pools_url(id:@address.pool_id)
    else
      flash[:notice] = "Pool Address not Updated try again!"
    end 
  end
  
  def show
    @pool = Pool.find_by_id(params[:id])
  end
  
  def new
    @pool = Pool.new
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
  end
  
  def create
    @pool = Pool.new(pool_params)
    @pool.company_id = current_user.company_id

    if @pool.save
      pool_address()
    end
    redirect_to pools_url
  end
  
  def edit
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
  end
  
  def update
    if @pool and @pool.update(pool_params)
      pool_address()
    end
    redirect_to pools_url
  end

  def pool_estimate
    @pool = Pool.find_by_id(params[:id])
    if !@pool.blank?
      estimate = (params[:estimate_map].to_f*3.28*6*7.48052).round(2) rescue "0.0" 
      if @pool.update(estimate_map: estimate) 

      end 
    end
  end

def destroy
  if @pool and @pool.destroy

  end
  redirect_to pools_url
end

def pool_data_new
  @pool = PoolDatum.new
end

def pool_data_create
  @pool = PoolDatum.new(data_params)
  @pool.pool_id = Pool.find_by_company_id( current_user.company_id).id
  if @pool.save
    flash[:notice] = "Pool Data Saved Successfully!"
  else
    flash[:notice] = "Pool Data not Saved try again!"
  end
end

def pool_data_edit
  @pool = PoolDatum.find_by_id(params[:id])
end

def pool_data_update
  @pool = PoolDatum.find_by_id(params[:id])
  if @pool.update(data_params)
    flash[:notice] = "Pool Data Updated!"
  else
    flash[:notice] = "Pool Data not Updated try again!"
  end 
end

def spa_data_new
  @spa = PoolDatum.new
end

def spa_data_create
  @spa = PoolDatum.new(data_params)
  @spa.pool_id = Pool.find_by_company_id( current_user.company_id).id
  if @spa.save
    flash[:notice] = "Spa Data Saved Successfully!"
  else
    flash[:notice] = "Spa Data not Saved try again!"
  end
end

def spa_data_edit
  @spa = PoolDatum.find_by_id(params[:id])
end

def spa_data_update
  @spa = PoolDatum.find_by_id(params[:id])
  if @spa.update(data_params)
    flash[:notice] = "Spa Data Updated!"
  else
    flash[:notice] = "Spa Data not Updated try again!"
  end 
end


private

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
