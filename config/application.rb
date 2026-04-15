# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RailsDeveloperProject65
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    # Set default locale to Russian
    config.i18n.default_locale = :ru
    config.i18n.available_locales = %i[ru en]

    # Настройка сессий для OmniAuth
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_bulletin_board_session'
  end
end
