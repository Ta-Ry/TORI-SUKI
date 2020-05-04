Rails.application.routes.draw do
  root 'home#top'
  get 'home/top'
  get 'home/about'
  get 'home/bird_hospital'
  get 'home/lost_bird'
  get 'home/contact'
  devise_for :users
  get 'users/follow_list/:user_id' => 'users#follow_list', as: 'follow_list'
  get 'users/follower_list/:user_id' => 'users#follower_list', as: 'follower_list'
  get 'users/withdrawal', to: 'users#withdrawal'
  put "/users/:id/hide" => "users#hide", as: 'users_hide'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:edit, :show, :index, :create, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:update, :edit, :show, :index, :ensure_correct_user]
  resources :relationships, only: [:create, :destroy]
end
