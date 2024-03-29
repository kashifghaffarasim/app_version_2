class JobsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_job, only: [:edit, :update, :destroy, :show, :job_status]
  
	def index
    session.delete(:convert)
    session[:type] = "Job"
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
    @jobs = Job.where(job_type: "Job", company_id: current_user.try(:company_id))
	end
  
  
  def customer_pool
    session.delete(:pool_id)
    @user = User.find_by_id(params[:user_id])
    @pools = Pool.where(user_id: params[:user_id])
    if @pools.count == 1
      session[:pool_id] = @pools.last.try(:id)
      if session[:type] == 'Estimate'
        redirect_to new_estimate_url
      else
        redirect_to new_job_url
      end
    end
  end
  
  
	def show
    @pool= @job.pool
    0.times {@job.line_items.build} 
	end

	def new
    if session[:pool_id].blank?
      @pool = Pool.find_by_id(params[:pool_id])
    else 
      @pool = Pool.find_by_id(session[:pool_id])
    end
    @team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
    @job = Job.new(job_type: 'Job')
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"jobs")

	end

  
	def create
		@job = Job.create(job_params)
		if @job.save
      days = (@job.end_date.to_date - @job.start_date.to_date ).to_i
      if days > 0
        Job.visit_plans(days, @job)
      end
      begin
        current_user.custom_fields(params[:custom_field],  @job.id)
      rescue
      end
			flash[:notice] = "Job Created!"
			redirect_to job_url(id: @job.id)
		else
			flash[:notice] = "Job did not Create!"
			render :new
		end
	end

	def edit
   
    @pool= @job.pool
    @team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
    0.times {@job.line_items.build}
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"jobs")

	end

	def update
		@job = Job.find_by_id(params[:id])
    if  session[:convert] == "Job"
      params[:job][:job_type] = 'Job'
    end
		if @job and  @job.update(job_params)
      days = (@job.end_date.to_date - @job.start_date.to_date ).to_i
      
      if days > 0
        Job.visit_plans(days, @job)
      end
      begin
        current_user.custom_fields(params[:custom_field],  @job.id)
      rescue
      end
			flash[:notice] = "Job updated!"
			redirect_to jobs_url
		else
			flash[:notice] = "Job did not update!"
			render :edit
		end

	end

	def destroy
		if @job and @job.destroy
			flash[:notice] = "Job Destroy!"
			redirect_to jobs_url
		else
			flash[:notice] = "Job did not Destroy!"
			redirect_to jobs_url
		end
	end
  
  def assign_job
    @visit = JobAssignVisit.find_by_id(params[:visit_id])
  end
  
  
  def job_assignment
    @visit =  JobAssignVisit.find_by_id(params[:id])
    if @visit and @visit.update(visit_params)
      
    end
    flash[:success] = "Plan visit updated."
    redirect_back(fallback_location: job_url(@visit.job))
  end
  
  def job_status
    status = params[:status]
    if @job and @job.update(status: params[:status])
      if @job.status == 'completed'
        
        if @job.invoice.blank?
          create_invoice()
          redirect_to new_invoice_url
        else
          redirect_back(fallback_location: job_url(@job))
        end
        
      else
        redirect_back(fallback_location: job_url(@job))
      end
    else
      redirect_back(fallback_location: job_url(@job))
    end
    
  end
  
  
	private
  
	def job_params
		params.require(:job).permit(:user_id, :company_id, :customer_id,
      :pool_id, :job_number,  :job_type, :assign_to, :schudle,
      :start_date, :end_date, :status,:description,
      line_items_attributes: [:name, :description, :quantity, :unit_cost, :total, :_destroy,:id])
	end

  def visit_params
    params.require(:visit).permit(:user_id, :start_time, :end_time, :status)
  end
  
  def get_job
    @job = Job.find_by_id(params[:id])
  end
  
  def create_invoice
    @invoice = Invoice.create(job_id: @job.try(:id), tax: @job.tax, discount: @job.discount ,
      desposit: @job.deposit, sub_total: @job.sub_total, grand_total: @job.grand_total,
      user_id: current_user.id, status: 'In Progress', company_id: @job.company_id)
    session[:invoice_id] = @invoice.try(:id)
  end
  
end
