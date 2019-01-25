class LeadsController < ApplicationController

	def index
		@leads = User.where(status: "lead")
	end

	def map
		@leads = User.where(status: "lead")
	end
	def quick_books
	end
	def new
		@lead = User.new
	end

	def create 
		require 'csv'
		if !params["file"].blank?
			csv_text = File.read(params["file"].tempfile)
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |lead|
				if User.find_by_email(lead["email"]).blank?
					@lead = User.new({:first_name => lead["first_name"],:last_name => lead["last_name"],:email => lead["email"]})
					@lead.status = "lead"
					if @lead.save(:validate => false)
						@lead.add_role :customer
						lead_address(lead)
						#flash[:success] = "Lead Successfully Import!"
						#redirect_to leads_url
					else
						#flash[:danger] = "Lead not Import try again"
						#redirect_to leads_url
					end
				else
					#flash[:danger] = "Email Already Taken by other user."
				    #redirect_to leads_url
		     	end
		    end
	    else
		    flash[:danger] = "Please Select CSV File......!!!"
	     	redirect_to leads_url
	    end
    end

	private

	def params_leads

	end
	def address_params
		params.require(:address).permit(:address_name, :city_name , :address_name2 , :state_name , :country_name , :zipcode)
	end
	def lead_address(lead)
		if @lead.address.blank?
			@address = Address.new({:address_name => lead["address_name"],:city_name => lead["city_name"],:state_name => lead["state_name"],:country_name => lead["country_name"],:zipcode => lead["zipcode"]})
			@address.user_id = @lead.try(:id)
			if @address.save
				puts"nananna" ,@address.inspect
			end
		else

		end
	end

end
