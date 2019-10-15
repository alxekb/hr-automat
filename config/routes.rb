require 'sidekiq/web'

Rails.application.routes.draw do
  get 'quizes/index'
  get 'quizes/show'
  resources :quizzes
  resources :books

  namespace :admin do

    resources :sections

    resources :chapters

    resources :questions

    resources :tags
    resources :quizzes
    resources :books
    resources :users
    resources :announcements
    resources :notifications
    resources :services

    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
