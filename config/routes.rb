Rails.application.routes.draw do

  # 静的なページ
  root 'static_pages#home'
  get  '/about_app',    to: 'static_pages#about_app'
  get  '/about_me',   to: 'static_pages#about_me'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'employees#new'
  
  # ログイン関係
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/guest_login', to: 'sessions#guest'
  
  # 従業員関連
  resources :employees
  
  # 日報関連
  resources :reports, only: [:create, :destroy]
  
  # チャット関連
  get '/chat', to: 'rooms#show'
  resources :messages, only: :create
  mount ActionCable.server => '/cable'
  get '/show_additionally', to: 'rooms#show_additionally'
  
  # FAQ関係
  resources :faqs
  get '/faqs/serch', to: 'faqs#serch'

  # フォロー関連
  resources :employees do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  
end
