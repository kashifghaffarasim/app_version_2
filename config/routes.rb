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
  get '/data/pool_data_new', to: 'pools#pool_data_new' ,as: :new_pool_data
  post '/pools/pool_data_create', to: 'pools#pool_data_create', as: :pool_data_create
  get '/data/:id/pool_data_edit', to: 'pools#pool_data_edit' ,as: :edit_pool_data
  patch '/dat/pool_data_update/:id', to: 'pools#pool_data_update', as: :update_pool_data
  get '/data/spa_data_new', to: 'pools#spa_data_new' ,as: :new_spa_data
  post '/pools/spa_data_create', to: 'pools#spa_data_create' , as: :spa_data_create
  get '/data/:id/spa_data_edit', to: 'pools#spa_data_edit' ,as: :edit_spa_data
  patch '/data/spa_data_update/:id', to: 'pools#spa_data_update', as: :update_spa_data
end
