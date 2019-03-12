class CalendarsController < ApplicationController

	skip_before_action :verify_authenticity_token, only: [:destroy]
	before_action :get_job, only: [:index,:destroy,:update ,:edit, :create]
	include ActionView::Helpers::OutputSafetyHelper 

	def index
		
		puts "sshdhsdhsdh " , (@jobs.to_json).inspect
	end
	def new
		@team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
		@job = Job.new(job_type: 'Job')
		@pool = Pool.find_by_id(params[:pool_id])
	end

	def customer_pool
		session.delete(:pool_id)
		@user = User.find_by_id(params[:user_id])
		@pools = Pool.where(user_id: params[:user_id])
		
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
			render 'index.js.erb'
		else
			flash[:notice] = "Job did not Create!"
			render 'new.js.erb'
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
				render 'index.js.erb'
		else
			flash[:notice] = "Job Not Update Try Again!!!"
			render 'edit.js.erb'
		end
	end 
	def destroy
		@job = Job.find_by_id(params[:id])

		if @job.destroy
			flash[:notice] = "Job Destroy!!!"
			render 'index.js.erb'
		else

			flash[:notice] = "Job Not Destroy Try Again!!!"
			render 'index.js.erb'
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
		session.delete(:convert)
		session[:type] = "Job"
		@customers =  User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer).last(4)
		@jobs = Job.where(job_type: "Job", company_id: current_user.try(:company_id))
	end 
end
