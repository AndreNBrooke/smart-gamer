Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

	resources :users, only: [:edit, :update, :index]

 get "/home" => "home#index", as: :index
  post'users/:id/updatechart' => "users#update_chart", as: "update_chart"
  get "/admin" => "users#admin_page", as: "admin"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

	match '/auth/:provider/callback', to: 'sessions#create', via: :all
	delete '/logout', to: 'sessions#destroy', as: :logout
  get "/search" => "home#search", as: :search

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'home#index'
  root 'new_age#index'
  resources :user_achievements, only: [:new, :index, :create, :show]

  resources :users, only: :show do
    resources :commendation
  end

  resources :articles do
    resources :comments, except: [:index]
  end

  resources :followers, only: [:create]

  get "/user/create_user_notifications" => "users#create_user_notifications"

end
