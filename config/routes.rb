Rails.application.routes.draw do

  get 'tweets/new'
  get 'tweets/show'
  get 'tweets/index'
  devise_for :users
  root to: "homes#top"

  resources :tweets, only: [:new, :index, :show, :create, :destroy]

  get 'homes/top'
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
