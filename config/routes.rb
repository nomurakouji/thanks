Rails.application.routes.draw do
  root 'posts#index'
  namespace :admin do
    resources :posts
    resources :departments
    resources :users 
  end
  get :dashboard, to: 'posts#dashboard'
  devise_for :users
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  post '/homes/guest_admin_sign_in', to: 'homes#new_guestadmin'
  resources :posts
  resources :users, :only => [:index, :edit, :show, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
