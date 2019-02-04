class JobsController < ApplicationController

  before_action :authenticate_user!

	def index
    @customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
    @job = Job.all
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
		@job = Job.find_by_id(params[:id])
	end

	def new
    
    @pool = Pool.find_by_id(params[:pool_id])
		@job = Job.new(job_type: 'estimate')
    
	end

	def create
    kasjdkasjd
		@job = Job.create(job_params)
		if @job.save
			flash[:notice] = "Job Created!"
			redirect_to jobs_url
		else
			flash[:notice] = "Job did not Create!"
			render :new
		end
	end

	def edit
		@job = Job.find_by_id(params[:id])
	end

	def update
		@job = Job.find_by_id(params[:id])
		if @job.update(job_params)
			flash[:notice] = "job Updated!"
			redirect_to vendors_url
		else
			flash[:notice] = "Vendor did not Update!"
			render :edit
		end

	end

	def destroy
		@job = Job.find_by_id(params[:id])
		if @job.destroy
			flash[:notice] = "Job Destroy!"
			redirect_to jobs_url
		else
			flash[:notice] = "Job did not Destroy!"
			redirect_to jobs_url
		end
	end
  

	private
	def job_params
		params.require(:job).permit(:user_id,:name,:start_time,:amount,:description)
	end

end
