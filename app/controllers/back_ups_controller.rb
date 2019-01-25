class BackUpsController < ApplicationController

	def index 

	end 


	def generate_csv 
		require 'csv'
		@customer = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:customer)
		csv_string = CSV.generate do |csv|
			csv << %w{first_name last_name address_name address_type city_name state_name country_name zipcode username email company_name mobile_number phone_number}
			@customer.each do |customer| 
				csv << [customer.try(:first_name), customer.try(:last_name),customer.address.try(:address_name),customer.address.try(:address_type),customer.address.try(:city_name),customer.address.try(:state_name),customer.address.try(:country_name),customer.address.try(:zipcode),customer.try(:username),customer.try(:email),customer.try(:mobile_number),customer.try(:phone_number)]
			end
		end
		send_data csv_string,
		:type => 'text/csv; charset=iso-8859-1; header=present',
		:disposition => "attachment; filename=customer.csv"
	
	end 
	def import_csv 
		require 'csv'
		if !params["file"].blank?
			csv_text = File.read(params["file"].tempfile)
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |customer|
				if User.find_by_email(customer["email"]).blank?
					@customer = User.new({:first_name => customer["first_name"],:last_name => customer["last_name"],:email => customer["email"] ,:username => customer["username"],:mobile_number => customer["mobile_number"],:phone_number=> customer["phone_number"]})
					@customer.status = "customer"
					if @customer.save(:validate => false)
						@customer.add_role :customer
						customer_address(customer)
						#flash[:success] = "customer Successfully Import!"
						#redirect_to customers_url
					else
						#flash[:danger] = "customer not Import try again"
						#redirect_to customers_url
					end
				else
					#flash[:danger] = "Email Already Taken by other user."
				    #redirect_to customers_url
				end
			end
		else
			flash[:danger] = "Please Select CSV File......!!!"
			redirect_to back_ups_url
		end
	end 

	private 

	def address 
		if @customer.address.blank?
			@address = Address.new({:address_name => customer["address_name"],:city_name => customer["city_name"],:state_name => customer["state_name"],:country_name => customer["country_name"],:zipcode => customer["zipcode"],:company_name => customer["company_name"]})
			@address.user_id = @customer.try(:id)
			if @address.save
				puts"nananna" ,@address.inspect
			end
		else

		end
	end

end
