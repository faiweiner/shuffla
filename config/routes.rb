Rails.application.routes.draw do
  root :to => 'pages#home'
  resources :users
  resources :games
  get '/games/new/genre' => 'games#genre'
  get '/games/new/playlist' => 'games#playlist'
  get '/games/new/artist' => 'games#artist'

  resources :questions
  post '/questions/new' => 'questions#new'


  get '/login' => 'session#new'
  post '/login' => 'session#login_attempt'
  delete '/login' => 'session#logout'
end
