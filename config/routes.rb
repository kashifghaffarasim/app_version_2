Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
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

  namespace :settings do
    resources :pool_settings, only: [:index, :create , :edit, :show, :destroy,:update]
    resources :notification_options, only: [:index, :create , :edit, :show, :destroy,:update,:new]
  end
  
  resources :customers  do
    collection do
      get :list_customers
    end
  end
  resources :estimates do
    collection do
      post :convert_invoice
      post :send_email
    end
  end
  resources :invoices
  
  resources :jobs do
    collection do 
     get  :customer_pool
    end
  end
  
  resources :vendors
  resources :calendars
  resources :settings, only: [:index]
  resources :companies, only: [:index, :create, :edit, :update, :show]
  resources :profiles 
  resources :pools
  resources :team_members
  get '/dashboard' => 'dashboard#index'
  root 'welcomes#index'

  resources :pools do
    collection do
      get :map , via: [:get, :post]
      post :map_address , via: [:post]
    end
  end
  resources :plans
  resources :leads do
    collection do 
      get :map

    end
  end
  resources :routings, only: [:index]
  resources :back_ups do 
    collection do 
      get :generate_csv 
      post :import_csv
    end
  end
  resources :communications do
    collection do
      get :sents
      get :receives
    end

  end
  
  resources :line_items
  
  get 'attachment/:id', to: "communications#attachment", as: :attachment

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
