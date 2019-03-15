class UsersController < ApplicationController
  layout 'xtream-front'
  skip_before_action :verify_authenticity_token

  def index
    redirect_to new_user_url
  end

  def new
   
  end

  def create
    session[:user] = params[:user]
    @user = User.find_by_email(params[:user][:email])
    puts"ssssssssssssssssssssssssssssss", params.inspect
    if @user.blank?
      puts"sssssssssssssssssssssssssss"
      redirect_to companies_url
    else
      flash[:danger] = "Email Already Taken."
      render :new
    end
  end

  def signin

  end

  def user_signin
    @user = User.find_by_email(params[:user][:email])
    if !@user.blank?
      if @user.valid_password?(params[:user][:password])

        sign_in :user, @user
        if @user.has_role? :admin
          redirect_to admin_url
        else
          redirect_to root_url
        end
      else
        render :signin
        flash[:danger] = "Invalid Password."
      end
    else
      render :signin
      flash[:danger] = "User Did Not Exist With This Email."
    end

  end

  def signout
    sign_out current_user if current_user
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
  
end
