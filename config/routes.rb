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
  # ゲストログイン
  post '/guest_login', to: 'sessions#guest'

  
  # チャット機能
  get '/chat', to: 'rooms#show'
  resources :messages, only: :create
  mount ActionCable.server => '/cable'
  get '/show_additionally', to: 'rooms#show_additionally'
  
  # FAQ関係
  get '/faqs/serch', to: 'faqs#serch'
  
  resources :employees
  resources :reports,          only: [:create, :destroy]
  resources :faqs
end
