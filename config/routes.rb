Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  resources :projects
  resources :grades
  resources :routes do
    resources :comments
  end

  scope :auth do
    get 'is_signed_in', to: 'users#is_signed_in?'
    get 'current', to: 'users#current'
  end

  get "users/:id" => "users#show", as: "user"
  get "users/:user_id/comments" => "users/comments#index", as: "user_comments"
  delete "users/:user_id/comment/:id" => "users/comments#destroy", as: "destroy_user_comment"

  get "users/:user_id/routes" => "users/routes#index", as: "user_routes"
  delete "users/:user_id/route/:id" => "users/routes#destroy", as: "destroy_user_route"

  get "users/:user_id/projects" => "users/projects#index", as: "user_projects"
  delete "users/:user_id/project/:id" => "users/projects#destroy", as: "destroy_user_project"
  
  root 'main#dashboard'

  # To develop with a React Router:
  # comment out the above "root 'main#dashboard'"
  # uncomment below:

  # root 'main#landing'
  # get "/*path" => "main#landing"

end
