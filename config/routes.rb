# frozen_string_literal: true

Rails.application.routes.draw do
  # Корневой маршрут - главная страница
  root 'web/home#index'

  # Все контроллеры в скоупе web
  scope module: 'web' do
    # Ресурс bulletins
    resources :bulletins, only: [:index, :show, :new, :create] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    # Profile
    resource :profile, only: :show

    # Auth routes
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end

  # Админ-панель
  namespace :admin do
    resources :categories
    resources :bulletins, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch :publish
        patch :reject
        patch :archive
      end
    end
    resources :users, only: [:index, :edit, :update]
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
