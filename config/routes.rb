Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  namespace :api do
    namespace :v1 do
      resources :post, only: %i[index show]
    end
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :suggestions, only: %i[create new]
  end
  resources :suggestions, only: %i[index update destroy show] do
    resources :replies, only: [:create]
  end
  resources :comments, only: [:destroy]
  resources :likes, only: %i[create destroy]
  resources :reports, only: %i[create show index destroy]
  resources :users, only: [:index]
  resources :approves
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'
end
