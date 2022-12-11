Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
    root :to =>"homes#top"
    get "home/about"=>"homes#about"
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
  	  get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
    get '/search', to: 'searches#search'
    resources :chats, only: [:show, :create]
  end
  namespace :admin do
    root :to =>"homes#top"
    resources :customers, only: [:index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
