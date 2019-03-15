class Auth::IntuitsController < ApplicationController
  
  before_action :authenticate_user!

  def index
     
  end
  
  def authenticate
    callback = oauth_callback_auth_intuits_url
    token = $qb_oauth_consumer.get_request_token(:oauth_callback => callback)
    session[:qb_request_token] = token
    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  end
  
  def oauth_callback
    redirect_to :back
  end

end
