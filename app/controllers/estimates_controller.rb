class EstimatesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_pool, only: [:new]
  before_action :get_estimate, only: [:show , :edit, :update, :destroy]
    
  def index
    session.delete(:convert)
    session[:type] = "Estimate"
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
    @estimates = Job.where(company_id: current_user.try(:company_id), job_type: 'Estimate')
  end
  
  
  def new
    if session[:pool_id].blank?
      @pool = Pool.find_by_id(params[:pool_id])
    else 
      @pool = Pool.find_by_id(session[:pool_id])
    end
    @estimate = Job.new()
    1.times {@estimate.line_items.build} 
  end
  
  def create
    @job = Job.new(estimate_params)
    if @job.save
      session.delete(:pool_id)
      flash[:success] = "Estimate Creared Successfully."
      redirect_to estimates_url
    else
      flash[:danger] = "Estimate not Created. Please try again later."
      render :new
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @estimate and @estimate.update(estimate_params)
      flash[:success] = "Estimate update Successfully."
      redirect_to estimates_url
    else
      flash[:danger] = "Estimate not Created. Please try again later."
      render :edit
    end
  end
  
  def destroy
    if @estimate.destroy
      flash[:success] = "Estimate Destroy!"
      redirect_to estimates_url
    else
      flash[:danger] = "Estimate did not Destroy!"
      redirect_to estimates_url
    end
  end
  
  
  def convert_invoice
    session[:convert] = "Job"
    @job = Job.find_by_id(params[:id])
    redirect_to edit_job_url(@job)
  end
  
  private
  
  def estimate_params
  
		params.require(:job).permit(:user_id, :company_id, :customer_id,
      :pool_id, :job_number,  :job_type, :assign_to, :sub_total , :discount , :tax , :grand_total, :deposit, :rating,
      line_items_attributes: [:name, :description, :quantity, :unit_cost, :total, :_destroy,:id])
  end
  
  def get_estimate
    @estimate = Job.find_by_id(params[:id])
    @pool= @estimate.pool
  end
  
  def get_pool
    @company = current_user.try(:company_id)
  end
  
end
