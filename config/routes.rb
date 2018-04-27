Rails.application.routes.draw do
  root to: 'users#index', as: 'usuarios'
  # WEB
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # API
  namespace :rest do
    get 'index', to: 'users#index', as: 'user_api'
    post 'verify_user/:mail', to: 'users#verify_user', constraints: { mail: %r{[^\/]+} }, as: 'verify_biometric'
  end
end
