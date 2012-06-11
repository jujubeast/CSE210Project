App::Application.routes.draw do

  get "stores/new"
  get "store/new"

  #test pages
  get "test/setup"
  get "test/simple_search_test_input"
  post "test/test_simple_search"

  #match '/', :to => "sessions#new"
  match '/', :to => "login#show"
  match "/stores/:id", :to => "stores#show", :as => :show_store
  match "/add_review", :to => "stores#addreview"

  post "/users", :to => "users#create"
  post "/lists", :to => "lists#create"
  post "/sessions", :to => "sessions#create"
  post "/stores", :to => "stores#create"

  match "/search/advanced", :to => "simple_search#search_advanced", :as => :search_advanced
  match "/search/get_list", :to => "simple_search#get_list"
  match "/search/approve_tag", :to => "simple_search#approve_tag"

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
  match "/search/", :to => "simple_search#search"

  match "/login", :to => "login#show"
  match "/homepage/:access_token", :to => "login#login"

  match "/showcurrlists", :to => "lists#show_curr_lists", :as => :show_curr_lists
  match "/showpossiblelists", :to => "lists#show_possible_lists", :as => :show_possible_lists
  match "/showcurrlisters", :to => "lists#show_curr_listers", :as => :show_curr_listers

  match "/view-tags", :to => "stores#view_tags"
  match "/add-tags", :to => "stores#add_tags"
  
  # this line giving error while running the server
  #resources :sessions, :only [:new, :create, :destroy]

  #resources :users

  # match '/signup', :to => 'users#new'

end
