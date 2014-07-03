Rails.application.routes.draw do
  root :to => 'pages#home'

  resources :users
  resources :games

  get '/games/new/genre' => 'games#genre'
  get '/games/new/playlist' => 'games#playlist'
  get '/games/new/artist' => 'games#artist'

  resources :questions
  post '/questions/new' => 'questions#new'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#login_attempt'
  delete '/login' => 'sessions#logout'
  
  # match 'auth/:provider/callback', to: 'sessions#fb_login_attempt', via: [:get, :post]
  # match 'auth/failure', to: redirect('/'), via: [:get, :post]
  # match 'signout', to: 'sessions#logout', as: 'logout', via: [:get, :post]
end
