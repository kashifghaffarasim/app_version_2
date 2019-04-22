class Api::V1::JobsController < ApplicationController

	def index

	end 

	def new

	end 

	def create 
		@job = Job.create(job_params)
		if @job.save 
			days = (@job.end_date.to_date - @job.start_date.to_date ).to_i
			if days > 0
				Job.visit_plans(days, @job)
			end
			render :json=> {
				:success => "Job created."
			},:status => 400
		else
			render :json=> {
				:error => "Job did not created. Please try again."
			},:status => 400
		end 
	end 

	def update 

	end 
	def destory

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
