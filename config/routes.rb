Rails.application.routes.draw do
  root 'welcome#index'
  resources :admins do
    get :confirm, on: :member
    get :deny, on: :member
  end
  resources :users do
    get :userbinding, on: :collection
    get :userscore, on: :collection
    get :sns_oauth2, on: :collection
    get :sns_userinfo, on: :collection
    get :ticket, on: :collection
    get :token, on: :collection
    get :finduser, on: :collection
    get :modifyuser, on: :collection
  end
  resources :serials do
    get :scan, on: :collection
    get :build_serial, on: :collection
  end
  resources :records do
    post :weixin, on: :collection
    get :receive, on: :member
  end
  resources :products do
    patch 'create_multiple', :on => :member
    patch 'download', :on => :member
    resources :extentions
    resources :serials do
      get :scan, on: :collection
      get :build_serial, on: :collection
    end
  end
  resources :prizes
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  namespace :api do
    resources :users, only: [:create, :update, :show], defaults: {format: :json} do
      # get :send_code, on: :collection, defaults: {format: :json}
    end
  end
end
