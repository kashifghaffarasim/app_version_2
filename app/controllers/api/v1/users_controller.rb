class Api::V1::UsersController < ApplicationController
		skip_before_action :verify_authenticity_token

	def create
		session[:user] = params[:user]
			@already = User.find_by_email(params[:user][:email])
		if @already.blank?
			@user = User.new(user_params)
			if @user.save
				#ApplicationMailer.registration_confirmation(@user).deliver
				sign_in :user, @user
			else
				render :json=> {
					:error => "Account did not created. Please try again later."
				},:status => 400
			end
		else
			render :json=> {
					:error => "Email Already Taken."
				},:status => 400
				
		end
	end

	def user_signin
		@user = User.find_by_email(params[:user][:email])
		if !@user.blank?
			if @user.valid_password?(params[:user][:password])
				sign_in :user, @user
			else
				render :json=> {
					:error => "Invalid Password."
				},:status => 400

			end
		else
			render :json=> {
				:error => "User did not exist with this Email."
			},:status => 400
		end

	end
	def signout
		sign_out current_user if current_user
	end
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end
end
