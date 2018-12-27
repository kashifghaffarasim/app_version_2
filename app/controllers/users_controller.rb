class UsersController < ApplicationController

  layout :another_by_method  
  def index

  end

  def new
    
  end

  def create
    puts"Update all users"
#    @user = User.new(user_params)
#    if @user.save
#      sign_in :user, @user
#      redirect_to root_url
#    else
#      flash[:error] = "Invalid Credentials."
#      redirect_to new_url
#    end
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
        flash[:error] = "Invalid Password."
      end
    else
      render :signin
      flash[:error] = "User Did Not Exist With This Email."
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
  def another_by_method
    if current_user.nil?
        "xtream-front"
    else
      "application"
    end
  end
end
