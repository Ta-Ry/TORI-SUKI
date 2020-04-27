Rails.application.routes.draw do
  root 'home#top'
  get 'home/top'
  get 'home/about'
  get 'home/bird_hospital'
  get 'home/lost_bird'
  get 'home/contact'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:edit, :show, :index, :create, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:update, :edit, :show, :index, :ensure_correct_user]
  resources :relationships, only: [:create, :destroy]
end
