Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "users/show" => "users#show"
  get '/users' => "users#index"
  get "users/:id" => "users#show", as: :mypage
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
 
  
end