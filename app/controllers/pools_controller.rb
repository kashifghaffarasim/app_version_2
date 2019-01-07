class PoolsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_pool, only: [:show, :edit, :update, :destroy]
  
  def index
    @pools = Pool.where(company_id: current_user.try(:company_id)).order(id: :asc)
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
  
  def destroy
    if @pool and @pool.destroy
      
    end
    redirect_to pools_url
  end

  private
  
  def pool_params
    params.require(:pool).permit(
      :pool_name ,:pool_description ,:pool_type , :pool_volume , :user_id,
      :pool_volume2, :pool_gate_code, :pool_source_type, :pool_lifeguards,
      :pool_activity)
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
