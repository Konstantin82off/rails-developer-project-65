# frozen_string_literal: true

Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN', nil)

  # Here we'll disable in 'test':
  if Rails.env.test?
    config.enabled = false
  end

  # === ENVIRONMENT & VERSION TRACKING ===
  # Set environment from Rails
  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env

  # Add code version for release tracking (for tracking deploys)
  config.code_version = ENV['GIT_SHA'] || '1.0.0'

  # Set framework explicitly
  config.framework = "Rails: #{Rails::VERSION::STRING}"

  # === EXCEPTION FILTERING ===
  # Ignore common non-actionable exceptions
  config.exception_level_filters.merge!(
    'ActiveRecord::RecordNotFound' => 'ignore',
    'ActionController::RoutingError' => 'ignore',
    'ActionController::InvalidAuthenticityToken' => 'warning',
    'ActiveStorage::FileNotFoundError' => 'ignore'
  )

  # === PRIVACY / SCRUBBING (PII SAFETY) ===
  # Scrub sensitive fields from logs
  config.scrub_fields |= %i[
    password
    password_confirmation
    secret
    token
    api_key
    access_token
    oauth_token
    credit_card
    cvv
  ]

  # Scrub sensitive headers
  config.scrub_headers |= %w[
    Authorization
    X-Api-Key
    Cookie
  ]

  # === CLIENT-SIDE JAVASCRIPT TRACKING ===
  # Report client-side JavaScript errors using rollbar.js
  config.js_enabled = true
  config.js_options = {
    accessToken: ENV.fetch('ROLLBAR_CLIENT_TOKEN', nil), # Use your post_client_item token
    captureUncaught: true,
    captureUnhandledRejections: true,
    payload: {
      environment: Rails.env,
      client: {
        javascript: {
          code_version: ENV['GIT_SHA'] || '1.0.0'
        }
      }
    }
  }

  # === PERSON TRACKING (FOR WHEN AUTH IS ADDED) ===
  # Add person (user) information for when authentication is added
  config.person_method = 'current_user'
  config.person_id_method = 'id'
  config.person_username_method = 'username'
  config.person_email_method = 'email'

  # === PERFORMANCE (OPTIONAL, CAN ENABLE LATER) ===
  # Enable async reporting for better performance
  # config.use_async = true

  # For Sidekiq (when you add background jobs)
  # config.async_handler = proc { |payload|
  #   RollbarJob.perform_later(payload)
  # }

  # === ADDITIONAL CONFIGURATION (KEEP AS IS) ===
  # By default, Rollbar will try to call the `current_user` controller method
  # to fetch the logged-in user object, and then call that object's `id`
  # method to fetch this property. To customize:
  # config.person_method = "my_current_user"
  # config.person_id_method = "my_id"

  # Additionally, you may specify the following:
  # config.person_username_method = "username"
  # config.person_email_method = "email"

  # If you want to attach custom data to all exception and message reports,
  # provide a lambda like the following. It should return a hash.
  # config.custom_data_method = lambda { {:some_key => "some_value" } }

  # Enable asynchronous reporting (uses girl_friday or Threading if girl_friday
  # is not installed)
  # config.use_async = true
  # Supply your own async handler:
  # config.async_handler = Proc.new { |payload|
  #  Thread.new { Rollbar.process_from_async_handler(payload) }
  # }

  # Enable asynchronous reporting (using sucker_punch)
  # config.use_sucker_punch

  # Enable delayed reporting (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'default'

  # If your application runs behind a proxy server, you can set proxy parameters here.
  # If https_proxy is set in your environment, that will be used. Settings here have precedence.
  # The :host key is mandatory and must include the URL scheme (e.g. 'http://'), all other fields
  # are optional.
  #
  # config.proxy = {
  #   host: 'http://some.proxy.server',
  #   port: 80,
  #   user: 'username_if_auth_required',
  #   password: 'password_if_auth_required'
  # }

  # If you run your staging application instance in production environment then
  # you'll want to override the environment reported by `Rails.env` with an
  # environment variable like this: `ROLLBAR_ENV=staging`. This is a recommended
  # setup for Heroku. See:
  # https://devcenter.heroku.com/articles/deploying-to-a-custom-rails-environment
  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
