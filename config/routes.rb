Rails.application.routes.draw do
  root                  		       'static_pages#home'
  post   '/select_community',  to: 'static_pages#set_community', 
                                    as: 'select_community'
  post   '/branch_feed',       to: 'static_pages#show_branch_feed',
                                    as: 'show_branch_feed'
  post   '/hide_branch_feed',  to: 'static_pages#hide_branch_feed',
                                    as: 'hide_branch_feed' 
  get    '/signup', 		       to: 'users#new'
  post   '/signup',			       to: 'users#create'
  get    '/index',  		       to: 'users#index'
  get    '/login', 			       to: 'sessions#new'
  post   '/login',  		       to: 'sessions#create'
  delete '/logout',  		       to: 'sessions#destroy'
  post   '/communities/new',   to: 'communities#create'
  post   '/sort_ideas',        to: 'communities#sort_ideas'
  post   '/sort_branch_ideas', to: 'ideas#sort_branch_ideas'
  resources :users do
  	member do
  		get :communities
  	end
  end
  resources :communities
  resources :memberships,  only: [:create, :destroy]
  resources :ideas,        only: [:create, :destroy, :show]
  resources :branch_ideas, only: [:create, :destroy]
  resources :votes,        only: [:create, :destroy]
  resources :temp_boxes,   only: [:create, :destroy]
end