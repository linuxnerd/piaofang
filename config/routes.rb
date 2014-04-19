Piaofang::Application.routes.draw do
  get "demo/index"
  resources :movies, only: [:index, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :honor do
    collection do
      get 'search'
    end
  end
  match '/admin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  root to: 'boxoffices#index'

  # grape api
  mount Boxoffice::API => '/'
end
