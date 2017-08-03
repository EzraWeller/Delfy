Rails.application.routes.draw do
  root                  		  'static_pages#home'
  get    '/signup', 		  to: 'users#new'
  post   '/signup',			  to: 'users#create'
  get    '/index',  		  to: 'users#index'
  get    '/login', 			  to: 'sessions#new'
  post   '/login',  		  to: 'sessions#create'
  delete '/logout',  		  to: 'sessions#destroy'
  post   '/communities/new',  to: 'communities#create'
  resources :users do
  	member do
  		get :communities
  	end
  end
  resources :communities
  resources :memberships, only: [:create, :destroy]
end