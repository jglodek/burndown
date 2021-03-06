Burndown::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

	resources :sessions
  resources :users
  resources :projects
	resources :backlog_items
	resources :evaluations
	
	put '/project/:id/finish' => "projects#finish", :as => "project_finish"
	put '/project/:id/unfinish' => "projects#unfinish", :as => "project_unfinish"
	
	get '/invitation/:id' => "invitations#join", :as => "join_project"
	get '/projects/:id/share'	=> "projects#create_invitation_link", :as=> "new_invitation_link"
	delete '/invitation/:id' => "invitations#destroy", :as=> "invitation_link"
	
	put '/projects/:id/:id2' => "projects#make_owner", :as=> "make_owner"
	delete '/projects/:id/:id2' => "projects#block_user", :as=> "block_user"
	
	get '/backlog_items/:id/finish'=> "backlog_items#finish", :as => "finish_backlog_item"
	
	get '/logout' =>'sessions#destroy'
  get '/login'  => 'sessions#new'
  post '/register' =>'users#create'
  get '/signup' =>'users#new'
  get '/account' => 'users#show'
	match '/account/change_name' => 'users#edit_name'
	match '/account/change_email' => 'users#edit_email'
	match '/account/change_password' => 'users#edit_password'
	match '/account/delete' => 'users#destroy'
	
  get '/home' => 'pages#home'
	get '/help' => 'pages#help'
	get '/terms_of_use' => 'pages#terms_of_use'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

	root :to => 'pages#home'
	
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
