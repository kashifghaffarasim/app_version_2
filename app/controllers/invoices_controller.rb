class InvoicesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_invoice, only: [:new, :update]
  
  def index
    @invoices = Invoice.where(company_id: current_user.try(:company_id), status: ['Un Paid', "Delay", "Paid"]).order(id: :desc)
  end
  
  def new

  end
  
  def update
    if @invoice.status == 'In Progress'
      params[:invoice][:status] = 'Un Paid'
    end
    
    if @invoice && @invoice.update(invoice_params)
      
    else
      
    end
    redirect_to invoices_url
  end
  
  
  
  private
  
  def invoice_params
    params.require(:invoice).permit(:subject, :payment, :issued_date, :status)
  end
  
  def get_invoice
    @invoice = Invoice.find_by_id(session[:invoice_id])
  end
  
end
