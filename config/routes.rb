Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'posts#index'
  # 下書きの一覧画面
  get :draft, to: 'posts#draft'
  # gemのdevise
  devise_for :users
  # 管理者機能
  namespace :admin do
    resources :posts
    resources :departments
    resources :users 
  end
  # ダッシュボード画面
  get :dashboard, to: 'admin/posts#dashboard'
  # 使用説明画面
  # get :instructions, to: 'posts#instructions'
  # ゲスト一般、ゲスト管理者の作成
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  post '/homes/guest_admin_sign_in', to: 'homes#new_guestadmin'
  resources :posts
  resources :users, :only => [:index, :edit, :show, :update, :destroy]
  # いいね機能
  post 'like/:post_id' => 'likes#create', as: 'create_like'
  delete 'like/:post_id' => 'likes#destroy', as: 'destroy_like'
  # 通知機能
  resources :notifications, only: :index
  # フォロー機能
  resources :relationships, only: [:create, :destroy]
  # チャット機能
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:show,:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
