AbrS::Application.routes.draw do
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

  match 'shooter/new' => "shooter#new"  
  match 'shooter/create' => "shooter#create"
  match 'shooter/:id' => "shooter#show"
  match 'shooter/:id/results' => "shooter#results"
  match 'round/:id/show_ends' => 'round#show_ends'
  match 'round/:id/show_dist' => 'round#show_dist'
  match 'round/:id/show_shots' => 'round#show_shots'
  match 'round/:id/show_score' => 'round#show_score'
  match 'shooter/:id/breakdown' => "shooter#breakdown"
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'

  
  match 'league/:id/show' => 'league#show'
  match 'league/show' => 'league#show'
  match 'league/' => 'league#index'
  match 'league/new' => 'league#new'
  match 'league/create' => 'league#create'
  

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
  root :to => "sessions#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
