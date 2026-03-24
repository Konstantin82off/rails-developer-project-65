# frozen_string_literal: true

Rails.application.routes.draw do
  # Все контроллеры в скоупе web
  scope module: 'web' do
    # Корневой маршрут - главная страница с объявлениями
    root 'bulletins#index'

    # Ресурс bulletins
    resources :bulletins, only: %i[index show new create edit update] do
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
    delete 'logout', to: 'auth#destroy'
  end

  # Админ-панель (только для управления категориями и публикацией объявлений)
  namespace :admin do
    resources :categories
    resources :bulletins, only: :index do
      member do
        patch :publish
        patch :reject
        patch :archive
      end
    end
  end

  # Reveal health status on /up
  get 'up' => 'rails/health#show', as: :rails_health_check
end
