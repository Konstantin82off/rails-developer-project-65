# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_rollbar_context, if: -> { defined?(Rollbar) && respond_to?(:current_user) }

  private

  def set_rollbar_context
    Rollbar.scope!(
      person: {
        id: current_user&.id,
        username: current_user&.name,
        email: current_user&.email
      },
      custom: {
        request_id: request.uuid,
        user_agent: request.user_agent,
        ip_address: request.remote_ip,
        controller: params[:controller],
        action: params[:action]
      }
    )
  end
end
