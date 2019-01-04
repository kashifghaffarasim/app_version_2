Rails.application.routes.draw do
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users , only: [:index, :new, :create] do
  	collection do
  		get  :signin
  		post :user_signin  
  		get  :signout
  	end
  end
  
  
  resources :welcomes, only: [:index] do
  	collection  do
  		get :pricing 
      get :aboutus
      get :tours
      get :faqs
      get :contactus
    end
  end

  resources :customers
  resources :vendors
  resources :jobs
  resources :calendars
 # resources :address
  resources :settings, only: [:index]
  resources :companies, only: [:index, :create, :edit, :update, :show]
  resources :profiles 
  resources :pools
  resources :team_members
  get '/dashboard' => 'dashboard#index'
  root 'welcomes#index'
 #get '/settings/:id/edit_company', to: 'settings#edit_company', as: :edit_company
  #patch '/settings/update_company/:id', to: 'settings#update_company', as: :update_company
  get '/companies/:id/edit_address', to: 'companies#edit_address', as: :edit_address
  patch '/companies/update_address/:id', to: 'companies#update_address', as: :update_address
end
