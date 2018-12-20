Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users , only: [:index, :new] do
  	collection do
  		get :signin
  		post :user_signin  
  		get  :signout
  	end
  end
  
  resources :dashboard, only: [:index]
  resources :welcomes, only: [:index] do
  	collection  do
  		get :pricing 
      get :aboutus
      get :tours
      get :faqs
      get :contactus
  	end
  end

  
  root 'welcomes#index'
end
