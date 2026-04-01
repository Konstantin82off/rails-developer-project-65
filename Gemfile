# frozen_string_literal: true

source 'https://rubygems.org'

ruby '>= 4.0.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.0.0'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 6.0'
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'
gem 'mini_magick', '~> 4.11'

# State machine for bulletins
gem 'aasm'

# Search and pagination
gem 'kaminari'
gem 'ransack'

# Authentication
gem 'omniauth', '~> 2.1'
gem 'omniauth-github', '~> 2.0'
gem 'omniauth-oauth2', '~> 1.8.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# Authorization
gem 'pundit'

# Error tracking
gem 'rollbar'

group :development, :test do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Environment variables
  gem 'dotenv-rails', '~> 3.2'

  # Linters
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false

  # Use sqlite3 in development and test
  gem 'sqlite3', '~> 2.0'

  # For generating test data
  gem 'faker'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  # Fix compatibility with Rails 8.0
  gem 'minitest', '~> 6.0'
end

group :production do
  # Use PostgreSQL in production (for Render)
  gem 'pg'
end
