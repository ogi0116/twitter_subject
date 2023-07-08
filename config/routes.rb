Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/index'
  devise_for :users
  root to: "homes#top"

  resources :tweets, only: [:new, :index, :show, :create, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


   resources :users, only: [:show, :edit, :update, :destroy] do
     member do
       get :favorites
     end
     resource :relationships, only: [:create, :destroy]
     get :follows, on: :member
     get :followers, on: :member
   end


  get 'homes/top'
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
