# frozen_string_literal: true

OmniAuth.config.full_host = if Rails.env.development?
                              'http://localhost:3000'
                            else
                              'https://rails-developer-project-65-kwud.onrender.com'
                            end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  github_options = { scope: 'user' }
  github_options[:provider_ignores_state] = true if Rails.env.development?

  provider :github, ENV.fetch('GITHUB_CLIENT_ID', ''), ENV.fetch('GITHUB_CLIENT_SECRET', ''), github_options
end
