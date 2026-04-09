# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root 'bulletins#index'

    resources :bulletins, only: %i[index show new create edit update destroy] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    resource :profile, only: :show
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'logout', to: 'auth#destroy'
  end

  namespace :admin, module: 'web/admin', as: :admin do
    root to: 'home#index'
    resources :categories
    resources :bulletins, only: :index do
      member do
        patch :publish
        patch :reject
        patch :archive
      end
    end
    get 'all_bulletins', to: 'bulletins#all', as: :all_bulletins
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
