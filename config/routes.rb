Rails.application.routes.draw do
  get '/top', to: 'pages#top'
  get '/sign_up', to: 'users#sign_up'
  get '/sign_in',  to: 'users#sign_in'
  get '/sign_out', to: 'users#sign_out'

  post 'sign_up', to: 'users#sign_up_process', as: :sign_up_process
  post 'sign_in', to: 'users#sign_in_process', as: :sign_in_process

  resources :pages

  resources :users
  #  resources :memos
=begin
  get "product/index" => "product#index"
  get "product/show" => "product#show"
  get "product/show2" => "product#show2"
  get "product/show3" => "product#show3"
  get "product/show4" => "product#show4"
  get "product/show5" => "product#show5"
  get "product/show6" => "product#show6"
  get "product/show7" => "product#show7"
=end

  get "admin/index" => "admin#index"


  resources :hierxes
  resources :categories
  resources :pathxes do
    member do
      get "look"
      get "look2"
    end
    collection do
      match "searcha" => "pathxes#searcha", via: [:get, :post]
      match "searchb" => "pathxes#searchb", via: [:get, :post]
    end
  end
  resources :pathxbs
  resources :pathxcs, only: [:index] do
    collection do
      match "search" => "pathxcs#search", via: [:get, :post]
      match "searcha" => "pathxcs#searcha", via: [:get, :post]
      match "searchb" => "pathxcs#searchb", via: [:get, :post]
      match "searchc" => "pathxcs#searchc", via: [:get, :post]
      match "searchd" => "pathxcs#searchd", via: [:get, :post]
    end
  end

  resources :bookmarks

  # Defines the root path route ("/")
  root "pathxes#index"
end

=begin
Rails.application.routes.draw do
  resources :ys
  resources :users
  resources :proposers
  resources :prevotes
  resources :pathxes
  resources :pages
  resources :hierxes
  resources :choiceproposals
  resources :categories
  resources :bookmarks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
=end

