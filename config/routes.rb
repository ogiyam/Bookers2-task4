Rails.application.routes.draw do

   devise_for :users
   root to: 'homes#top'
   get "/home/about" => "homes#about"
   resources :books, only:[:index, :create, :show, :edit, :update, :destroy]
   resources :users, only: [:index, :show, :edit, :update]do
     resource :relationships, only: [:create, :destroy]
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
 end