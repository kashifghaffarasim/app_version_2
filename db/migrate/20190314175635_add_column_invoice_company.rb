class AddColumnInvoiceCompany < ActiveRecord::Migration[5.2]
  
  def change
    add_column :invoices, :company_id, :integer
  end
  
end
