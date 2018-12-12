Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	collection do
  		get :signin
  		post :user_signin  
  		get  :signout
  	end
  end
  resources :welcomes do
  	collection  do
  		get :pricing
  	end
  end

  root 'welcomes#index'
end
