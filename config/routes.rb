Rails.application.routes.draw do
  root 'home#top'
  get 'home/top'
  get 'home/about'
  get 'home/bird_hospital'
  get 'home/contact'
  devise_for :users
  get 'users/follow_list/:user_id' => 'users#follow_list', as: 'follow_list'
  get 'users/follower_list/:user_id' => 'users#follower_list', as: 'follower_list'
  get 'posts/favorite_list/:user_id' => 'posts#favorite_list', as: 'favorite_list'
  get 'users/withdrawal', to: 'users#withdrawal'
  get 'posts/all_tag', to: 'posts#all_tag', as: 'all_tag'
  put "/users/:id/hide" => "users#hide", as: 'users_hide'
  get 'search/search' => 'search#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:edit, :show, :index, :create, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:update, :edit, :show, :ensure_correct_user]
  resources :relationships, only: [:create, :destroy]
end
