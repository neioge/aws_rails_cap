Rails.application.routes.draw do
  get 'employees/new'
  get 'users/new'
  root 'static_pages#home'
  get  '/about_app',    to: 'static_pages#about_app'
  get  '/about_me',   to: 'static_pages#about_me'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'employees#new'
  resources :employees
end
