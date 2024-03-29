class TeamMembersController < ApplicationController
 
  before_action :authenticate_user!
	before_action :get_company, only: [:create]

	def index
		@team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
	end
  
	def new
		@team_member  = User.new
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"team_members")
	end 
  
	def show
		@team_member  = User.find_by_id(params[:id])
	end
  
	def create
		params[:user][:company_id] = @company_id
		params[:user][:password] = '12345678'
		@team_member  = User.new(user_params)
		@already = User.find_by_email(params[:user][:email])
		if @already.blank?
			if @team_member.save(validate: false)
				@team_member.add_role params[:user][:role]
				member_address()
        begin
          @team_member.custom_fields(params[:custom_field],  @team_member.id)
        rescue
        end
				flash[:success] = "Team Member Created Successfully!"
				redirect_to team_members_url
			else 
				flash[:danger] = "Team Member not Saved try again"
				render :new
			end
		else
			flash[:danger] = "Email already used with other users. Please try with new email"
			render :new
		end 
	end
	def edit
		@team_member = User.find_by_id(params[:id])
    @custom_field = CustomField.where(:user_id=>current_user.id ,:applies_to=>"team_members")
	end 
	
	def update
		@team_member = User.find_by_id(params[:id])
		if @team_member.update(user_params)
			@team_member.add_role params[:user][:role]
			member_address()
      begin
        @team_member.custom_fields(params[:custom_field],  @team_member.id)
      rescue
      end
			flash[:notice] = "Team Member updated!!!"
			redirect_to team_members_url
		else
			flash[:notice] = "Team Member not update try again"
			redirect_to team_members_url
		end
	end 
	
	def destroy
		@team_member = User.find_by_id(params[:id])
		if @team_member.destroy
			flash[:notice] = "Team Member Destroy!"
			redirect_to team_members_url
		else
			flash[:notice] = "Team Member did not Destroy!"
			redirect_to team_members_url
		end
	end
	private 

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :company_id ,:username, :phone_number, :mobile_number, :avatar)
	end
	def address_params
		params.require(:address).permit(:address_name, :city_name , :state_name , :country_name , :zipcode)
	end

	def get_company
		@company_id = current_user.try(:company_id)
	end

	def member_address
		if @team_member.address.blank?
			@address = Address.new(address_params)
			@address.user_id = @team_member.try(:id)
			if @address.save
			end
		else
			if @team_member.address.update(address_params)

			end
		end
	end
end
