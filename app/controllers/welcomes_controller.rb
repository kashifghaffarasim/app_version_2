class WelcomesController < ApplicationController
  layout "xtream-front"
  def index
    puts"ssssssssssssssssssssssss", current_user.inspect
    if current_user
      redirect_to dashboard_url
    end
  end
  
  def pricing
    
  end
  
  
  def aboutus
  end
  
  def tours
  end
  
  def faqs
    
  end
  
  def contactus
    
  end
end
