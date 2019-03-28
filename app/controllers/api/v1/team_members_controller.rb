class Api::V1::TeamMembersController < ApplicationController
	before_action :get_user 
	def index
		@team_members = User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
	end
	def create 
		@user = User.new(user_params)
		@already = User.find_by_email(param[:email])
		if @already.blank?
			if @user.save 
				#ApplicationMailer.registration_confirmation(@user).deliver
					member_address()
				render :json=> {
					:error => "User Account created."
				},:status => 400
				#sign_in :user, @user

			else
				render :json=> {
					:error => "User Account did not created. Please try again."
				},:status => 400
			end 
		else 
			render :json=> {
				:error => "Email already used. Please try again wit new email."
			},:status => 400
		end 
	end 

	def show 
		@user = User.find_by_id(params[:id])
	end 

	def destroy
		@user = User.find_by_id(params[:id])
		if @user.dastroy 
			render :json=> {
				:error => "User Account Destroy."
			},:status => 400
		else
			render :json=> {
				:error => "User Account did not Destroy. Please try again."
			},:status => 400
		end
	end 

	def update 
		@user = User.find_by_id(params[:id])
		if @user.update(user_params)
			render :json=> {
				:error => "User Account Updated."
			},:status => 400
		else
			render :json=> {
				:error => "User Account did not Update. Please try again."
			},:status => 400
		end 
	end
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :company_id ,:username, :phone_number, :mobile_number, :avatar)
	end

end
