Rails.application.routes.draw do
  root                  		           'static_pages#home'
  post   '/select_community',      to: 'static_pages#set_community', 
                                        as: 'select_community'
  post   '/branch_feed',           to: 'static_pages#show_branch_feed',
                                        as: 'show_branch_feed'
  post   '/hide_branch_feed',      to: 'static_pages#hide_branch_feed',
                                        as: 'hide_branch_feed' 
  get    '/branch_feed',           to: 'static_pages#get_branch_page'
  get    '/sort_branch_ideas',     to: 'static_pages#get_branch_page'
  get    '/votes',                 to: 'static_pages#get_branch_page'
  get    '/votes/:id',             to: 'static_pages#get_branch_page'
  get    '/signup', 		           to: 'users#new'
  post   '/signup',			           to: 'users#create'
  # get    '/index',  		          to: 'users#index'
  post   '/show_edit_form',        to: 'users#show_edit_form',
                                       as: 'show_edit_form'
  post   '/hide_edit_form',        to: 'users#hide_edit_form',
                                       as: 'hide_edit_form'
  patch  '/ask_current_pw',        to: 'users#ask_current_pw',
                                       as: 'ask_current_pw'
  get    '/users/:id/ideas',       to: 'users#ideas',
                                       as: 'users_ideas'
  get    '/login', 			           to: 'sessions#new'
  post   '/login',  		           to: 'sessions#create'
  delete '/logout',  		           to: 'sessions#destroy'
  post   '/communities/new',       to: 'communities#create'
  post   '/sort_ideas',            to: 'communities#sort_ideas'
  get    '/sort_ideas',            to: 'static_pages#home'
  post   '/sort_branch_ideas',     to: 'ideas#sort_branch_ideas'
  get    '/search_ideas',          to: 'ideas#search',
                                       as: 'search_ideas'
  get    '/communities/:id/admin', to: 'communities#admin',
                                       as: 'community_admin'
  post   '/communities/:id/admin', to: 'invitations#create_many',
                                       as: 'community_invites'
  resources :users do
  	member do
  		get :communities
  	end
  end
  resources :communities
  resources :memberships,         only: [:create, :destroy]
  resources :ideas,               only: [:create, :destroy, :show, :index]
  resources :branch_ideas,        only: [:create, :destroy, :show]
  resources :votes,               only: [:create, :destroy]
  resources :temp_boxes,          only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :invitations,         only: [:create]
end