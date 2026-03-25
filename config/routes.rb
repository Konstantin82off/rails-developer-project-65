# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root 'bulletins#index'

    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    resource :profile, only: :show
    get 'auth/github/callback', to: 'auth#callback'
    delete 'logout', to: 'auth#destroy'
  end

  # Админ-панель - правильный неймспейс
  namespace :admin, module: 'web/admin', as: :admin do
    resources :categories
    resources :bulletins, only: :index do
      member do
        patch :publish
        patch :reject
        patch :archive
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
