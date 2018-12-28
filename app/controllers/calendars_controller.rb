class CalendarsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:destroy]
	def index
		@job = Job.all
	end
	def new
		@job = Job.new
		@user = User.with_role(:vendor)
	end

	def show 
		@job = Job.find_by_id(params[:id])
	end 

	def create
		@job = Job.new(jobs_params)
		if @job.save 
			#@job.add_role :vendor
			flash[:notice] = "Job Created!!!"
			redirect_to calendars_url
		else
			flash[:notice] = "Job Not Create Try Again!!!"
			render :new  
		end 
	end 

	def edit 
		@job = Job.find_by_id(params[:id])
		@user = User.with_role(:vendor)
	end

	def update 
		@job = Job.find_by_id(params[:id])
		if @job.update(jobs_params)
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
	def jobs_params 
		params.require(:job).permit(:user_id,:name,:start_time,:amount,:description,:status,:end_time)
	end
end
