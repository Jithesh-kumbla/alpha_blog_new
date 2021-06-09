Rails.application.routes.draw do
  root  'pages#home'
  get 'about', to: 'pages#about'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#login'
  delete 'logout', to: 'sessions#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles
  get 'signup', to: "users#new"
  resources :users, except: [:new]
end
