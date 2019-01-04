class AddToCompanies < ActiveRecord::Migration[5.2]
	def change
		add_column :companies, :phone, :string 
		add_column :companies, :email, :string 
		add_column :companies, :website, :string 
		add_column :companies, :start_week, :string 
	end
end
