AbrS::Application.routes.draw do

  devise_for :users

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :rounds
  
  match 'round' => "round#new"
  match 'round/update' => "round#update"
  match 'round/new' => "round#new"
  match 'round/create' => "round#create"
  match 'round/:id' => "round#show"
  match 'round/:id/results' => "round#results"
  match 'round/:id/edit_score' => "round#edit_score"


  match 'user/:id' => "user#show"
  match 'user/:id/results' => "user#results"
  match 'user/:id/past_rounds' => "user#past_rounds"
  match 'user/:id/past_tournaments' => "user#past_tournaments"
  match 'user/:id/shot_histogram' => 'user#shot_histogram'
  match 'user/:id/join_league' => 'user#join_league'
  match 'users/sign_out' => 'user#sign_out'
  
  match 'round/:id/show_ends' => 'round#show_ends'
  match 'round/:id/show_dist' => 'round#show_dist'
  match 'round/:id/show_shots' => 'round#show_shots'
  match 'round/:id/show_score' => 'round#show_score'
  match 'shooter/:id/breakdown' => "shooter#breakdown"
  match 'shooter/:id/join_league' => "shooter#join_league"
  match 'shooter/:id/enter_tournament' => "shooter#enter_tournament"
  match 'shooter/enter_tournament' => "shooter#enter_tournament"
  match 'shooter/join_league' => 'shooter#join_league'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'


  match 'league/show' => 'league#show'  
  match 'league/:id/show' => 'league#show'
  match 'league/join' => 'league#join'
  match 'league/index'
  match 'league/' => 'league#index'
  match 'league/new' => 'league#new'
  match 'league/create' => 'league#create'
  match 'league/:id/results' => 'league#results'
  match 'league/:id/scores' => 'league#scores'
  match 'league/:id/update' => 'league#update'
  match 'league/:id/boxplot' => 'league#boxplot'
  
  match 'administration/show' => 'administration#show'
  match 'administration/upload' => 'administration#upload'
  match 'administration/show_shooters' => 'administration#show_users'
  match 'administration/show_leagues' => 'administration#show_leagues'
  match 'administration/toggle_admin' => 'administration#toggle_admin'
  match 'administration/delete_shooter' => 'administration#delete_shooter'
  match 'tournament/show' => 'tournament#show'  
  match 'tournament/:id/show' => 'tournament#show'
  match 'tournament/index'
  match 'tournament/' => 'tournament#index'
  match 'tournament/new' => 'tournament#new'
  match 'tournament/create' => 'tournament#create'
  match 'tournament/:id/results' => 'tournament#results'
  match 'tournament/:id/scores' => 'tournament#scores'
  match 'tournament/:id/update' => 'tournament#update'
  

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end


  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "user#show"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
