class Settings::ChemicalItemsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    if current_user.company
      @chemicals = ChamicalItem.where(company_id: current_user.company.try(:id)).order(id: :asc)
    else
      redirect_to root_url
    end
  end
  
  def create
    @chemicals = ChamicalItem.where(id:  params[:chemical_ids]).update_all(is_used: true)
    @chemicals = ChamicalItem.where.not(id:  params[:chemical_ids]).update_all(is_used: false)
    redirect_to settings_chemical_items_url
  end
  

end
