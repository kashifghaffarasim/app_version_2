class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      
      t.integer :job_id
      t.string :subject
      t.string :payment
      t.datetime :issued_date
      t.datetime :due_date
      t.string :tax
      t.string :discount
      t.string :desposit
      t.string :sub_total
      t.string :grand_total
      t.text    :message
      t.string :status, default: 'Unpaid'
      t.integer :user_id 
      t.datetime :bill_start_date
      t.datetime :bill_end_date
      t.timestamps
    end
  end
end
