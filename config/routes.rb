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
  
  resources :employees
end
