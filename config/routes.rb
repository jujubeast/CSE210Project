TestApp::Application.routes.draw do
 
  match '/', :to => "sessions#new"

  post "/users", :to => "users#create"
  post "/lists", :to => "lists#create"
  post "/sessions", :to => "sessions#create"
  match "users/:id/:cur_list", :to => "users#show"
  match "users/:id", :to => "users#show"
  match "/signup",  :to => "users#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"
  match "/createlist", :to => "lists#new"
  match "/deletelist/:id", :to => "lists#destroy"

  resources :sessions, only: [:new, :create, :destroy]
  
  #resources :users

 

 # match '/signup', :to => 'users#new'

end
