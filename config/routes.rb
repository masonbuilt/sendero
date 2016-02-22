Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  resources :projects
  resources :grades
  resources :routes do
    resources :comments
  end

  get "users/:id" => "users#show", as: "user"
  get "users/:user_id/comments" => "users/comments#index", as: "user_comments"
  delete "users/:user_id/comment/:id" => "users/comments#destroy", as: "destroy_user_comment"

  get "users/:user_id/routes" => "users/routes#index", as: "user_routes"
  delete "users/:user_id/route/:id" => "users/routes#destroy", as: "destroy_user_route"

  get "users/:user_id/projects" => "users/projects#index", as: "user_projects"
  delete "users/:user_id/project/:id" => "users/projects#destroy", as: "destroy_user_project"
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#dashboard'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
