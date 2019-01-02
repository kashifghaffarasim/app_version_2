class DashboardController < ApplicationController

  layout "application"
  before_action :authenticate_user!
  
  def index
    
  end


end
