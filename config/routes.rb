Rails.application.routes.draw do
  root 'welcome#index'
  resources :admins do
    get :confirm, on: :member
    get :deny, on: :member
  end
  resources :users do
    resources :scanlogs
    get :userbinding, on: :collection
    get :userscore, on: :collection
    get :sns_oauth2, on: :collection
    get :sns_userinfo, on: :collection
    get :ticket, on: :collection
    get :token, on: :collection
    get :finduser, on: :collection
    get :userdetail, on: :collection
    get :modifyuser, on: :collection
  end
  resources :serials do
    get :scan, on: :collection
    get :build_serial, on: :collection
    get :multi_create, on: :collection
    get :query, on: :collection
    patch 'create_multiple', :on => :member
    patch 'download', :on => :member
  end
  resources :records do
    post :weixin, on: :collection
    get :receive, on: :member
  end
  resources :products do

    resources :extentions
    resources :serials do
      get :scan, on: :collection
      get :build_serial, on: :collection
      get :scan, on: :member
      get :unable, on: :member
    end
  end
  resources :thirdparties
  resources :prizes
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  resources :reports do
    get :idx1_1, on: :collection
    get :idx1_2, on: :collection
    get :idx1_3, on: :collection
    get :idx1_4, on: :collection
    get :idx1_5, on: :collection
    get :idx1_6, on: :collection

    get :idx2_1, on: :collection
    get :idx2_2, on: :collection
    get :idx2_3, on: :collection

    get :idx3_1, on: :collection
    get :idx3_2, on: :collection
    get :idx3_3, on: :collection
    get :idx3_4, on: :collection
    get :idx3_5, on: :collection
    get :idx3_6, on: :collection
    get :idx3_7, on: :collection

    get :idx4_1, on: :collection
    get :idx4_2, on: :collection
    get :idx4_3, on: :collection

    get :idx5_1, on: :collection
    get :idx5_2, on: :collection
    get :idx5_3, on: :collection

    get :idx6_1, on: :collection
    get :idx6_2, on: :collection

    get :idx7_1, on: :collection
    get :idx7_2, on: :collection
    get :idx7_3, on: :collection

    get :idx8_1, on: :collection
    get :idx8_2, on: :collection
  end

  namespace :api do
    resources :users, only: [:create, :update, :show], defaults: {format: :json} do
      # get :send_code, on: :collection, defaults: {format: :json}
    end
  end
end
