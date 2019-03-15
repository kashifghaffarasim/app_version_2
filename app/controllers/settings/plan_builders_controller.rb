class Settings::PlanBuildersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_company, only: [:index, :new, :edit, :create]
  before_action :get_service_plan , only: [ :edit, :update, :destroy]
  
  def index
    @service_plans = ServicePlan.where(company_id: @company.try(:id))
  end
  
  def new
    @service_items = ServiceItem.all
  end
  
  def create 
    @service_plan = ServicePlan.new(service_params)
    @service_plan.company_id = @company.try(:id)
    if @service_plan.save
      @service_plan.service_create_or_update(@service_plan, params[:items_ids])
      
      redirect_to settings_plan_builders_url
    else
      
      redirect_to settings_plan_builders_url
    end
  end
  
  def edit
    @service_items = ServiceItem.all
  end
  
  def update
    if @service_plan && @service_plan.update(service_params)
      @service_plan.service_create_or_update(@service_plan, params[:items_ids])
    end
    redirect_to settings_plan_builders_url
  end
  
  
  def destroy
    if @service_plan && @service_plan.destroy
     
    end
    redirect_to settings_plan_builders_url
  end
  
 
  private

  def service_params
    params.require(:service_plan).permit(:name,:unit_cost, :description)
  end
  
  def get_company
    if current_user.company
      @company = current_user.company
    else
      redirect_to root_url
    end
  end
  
  def get_service_plan
    @service_plan = ServicePlan.find_by_id(params[:id])
  end
end
