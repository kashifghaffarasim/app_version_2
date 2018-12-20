class JobsController < ApplicationController

	def index
		@job = Job.all
	end

	def show
		@job = Job.find_by_id(params[:id])
	end

	def new
		@job = Job.new
	end

	def create
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
