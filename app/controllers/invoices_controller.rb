class InvoicesController < ApplicationController
  
  def index
    session[:type] = "Job"
  end
end
