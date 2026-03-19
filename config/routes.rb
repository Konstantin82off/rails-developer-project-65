# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Корневой маршрут - главная страница (теперь с указанием неймспейса web)
  root 'web/home#index'

  # Все контроллеры в скоупе web
  scope module: 'web' do
    # Ресурс bulletins
    resources :bulletins, only: [:index, :show, :new, :create]

    # Auth routes
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
