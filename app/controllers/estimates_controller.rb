class EstimatesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_pool, only: [:new]
    
  def index
    session[:type] = 'Estimate'
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
    @estimates = Job.where(company_id: current_user.try(:company_id), job_type: 'estimate')
  end
  
  
  def new
    if session[:pool_id].blank?
      @pool = Pool.find_by_id(params[:pool_id])
    else 
      @pool = Pool.find_by_id(session[:pool_id])
    end
    @estimate = Job.new(job_type: 'estimate')
    1.times {@estimate.line_items.build} 
  end
  
  def create
   
    puts"ssssssssssssssssssssssssss", params.inspect
    askjdkasjdkajs
    session.delete(:pool_id)

  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destory
    
  end
  
  def convert_to_job
    
  end
  
  private
  
  def estimate_params
    params[:job][:company_id] = current_user.try(:company_id)
    params[:job][:user_id] = current_user.try(:id)
		params.require(:job).permit(:user_id, :company_id, 
      :pool_id, :job_number,  :job_type, :assign_to, :sub_total , :discount , :tax , :grand_total,
        line_items_attributes: [:name, :description, :quantity, :unit_cost, :total])
  end
  
  def get_estimate
    
  end
  
  def get_pool
    @company = current_user.try(:company_id)
  end
  
end
