class JobsController < ApplicationController

	def index

	end

	def show
		
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.create(job_params)
		if @job.save

		else
		end

	end

	def edit
		
	end

	def update

	end

	def destroy

	end

	private

	def job_params
		params.require(:job).permit(:company_id,:user_id , :address_id,:pool_id,:name,:start_time,:amount,:description)
	end

end
