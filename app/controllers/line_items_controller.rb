class LineItemsController < ApplicationController
  
  before_action :get_job, only: [:create, :update]
  def new
   
  end
  
  def create
    if @job and @job.update(line_items_params)
       
    end
    redirect_to job_url(@job)
  end
  
  def update
    
    if @job and @job.update(line_items_params)
      sum = @job.line_items.sum(:total)
      if @job.update(sub_total: sum)
         
      end
    end
    redirect_to job_url(@job)
  end

  
  private
  
  def line_items_params
    params.require(:job).permit(:deposit, :rating,
      line_items_attributes: [:name, :description, :quantity, :unit_cost, :total, :_destroy, :id])
  end
  
  def get_job
    @job = Job.find_by_id(params[:job][:job_id])
  end
end
