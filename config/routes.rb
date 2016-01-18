Rails.application.routes.draw do
  root 'welcome#index'
  resources :admins
  resources :users do
    get :userbinding, on: :collection
    get :userscore, on: :collection
  end
  resources :serials do
    get :scan, on: :collection
  end
  resources :records do
    post :weixin, on: :collection
    get :receive, on: :member
  end
  resources :prizes
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
end
