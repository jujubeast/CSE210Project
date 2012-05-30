App::Application.routes.draw do
 
  get "stores/new"
  get "store/new"
  
  #test pages
  get "test/setup"
  get "test/simple_search_test_input"
  post "test/test_simple_search"
  
  match '/', :to => "sessions#new"
  #match '/', :to => "login#show"
  match "/stores/:id", :to => "stores#show", :as => :show_store
  match "/reviews", :to => "stores#addreview"
  post "/users", :to => "users#create"
  post "/lists", :to => "lists#create"
  post "/sessions", :to => "sessions#create"
  post "/stores", :to => "stores#create"
  
  match "/users/:id/:cur_list", :to => "users#show", :as => :default_home
  match "/users/:id", :to => "users#show", :as => :home
  match "/signup",  :to => "users#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"
  match "/createlist", :to => "lists#new"
  match "/deletelist/:id", :to => "lists#destroy", :as => :delete_list

  match "/addtolist/:list_id/:store_id", :to => "lists#add", :as => :add_to_list
  match "/removefromlist/:list_id/:store_id", :to => "list_stores#destroy", :as => :remove_from_list

  match "/addstore", :to => "stores#new"
  match "/login", :to => "login#show"
  match "/search/", :to => "simple_search#search"

  # this line giving error while running the server
  #resources :sessions, :only [:new, :create, :destroy]
  
  #resources :users

 

 # match '/signup', :to => 'users#new'

end
