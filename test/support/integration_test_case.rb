# frozen_string_literal: true

require_relative 'authentication_helpers'

module ActionDispatch
  class IntegrationTest
    include AuthenticationHelpers
  end
end
