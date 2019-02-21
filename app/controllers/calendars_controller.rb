class CalendarsController < ApplicationController

	skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :get_job, only: [:edit, :update, :destroy, :show]
	
   include ActionView::Helpers::OutputSafetyHelper 

	def index
		session.delete(:convert)
		session[:type] = "Job"
		@customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
		@jobs = Job.where(job_type: "Job", company_id: current_user.try(:company_id))
		puts "sshdhsdhsdh " , (@jobs.to_json).inspect
	end
	def new
		@team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
		@job = Job.new(job_type: 'Job')
		session.delete(:pool_id)
		@user = User.find_by_id(params[:user_id])
		@pools = Pool.where(user_id: params[:user_id])
		if @pools.count == 1
			session[:pool_id] = @pools.last.try(:id)
			if session[:type] == 'Estimate'
				redirect_to new_estimate_url
			else
				render "new.js.erb"
			end
		end
		if session[:pool_id].blank?
			@pool = Pool.find_by_id(params[:pool_id])
		else 
			@pool = Pool.find_by_id(session[:pool_id])
		end
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

	def create
		@job = Job.create(job_params)
		if @job.save
			days = (@job.end_date.to_date - @job.start_date.to_date ).to_i
			if days > 0
				Job.visit_plans(days, @job)
			end
			flash[:notice] = "Job Created!"
			redirect_to calendars_url
		else
			flash[:notice] = "Job did not Create!"
			render :new
		end
	end 

	def edit 
	   
    @pool= @job.pool
    @team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
    0.times {@job.line_items.build} 
	end

	def update 
		if @job.update(job_params)
			flash[:notice] = "Job Updated!!!"
			redirect_to calendars_url
		else
			flash[:notice] = "Job Not Update Try Again!!!"
			render :edit 
		end
	end 
	def destroy
		@job = Job.find_by_id(params[:id])
		if @job.destroy
			flash[:notice] = "Job Destroy!!!"
			redirect_to calendars_url
		else
			flash[:notice] = "Job Not Destroy Try Again!!!"
			render :edit 
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
end
