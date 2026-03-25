# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require_relative 'support/authentication_helpers'

OmniAuth.config.test_mode = true

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end

ActiveSupport.on_load(:action_dispatch_integration_test) do
  include AuthenticationHelpers
end
