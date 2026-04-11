# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = lambda do |_env|
  if Rails.env.development?
    'http://localhost:3000'
  else
    'https://rails-developer-project-65-kwud.onrender.com'
  end
end
OmniAuth.config.allowed_request_methods = %i[get post]
OmniAuth.config.silence_get_warning = true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV.fetch('GITHUB_CLIENT_ID', ''), ENV.fetch('GITHUB_CLIENT_SECRET', ''),
           scope: 'user',
           provider_ignores_state: true
end
