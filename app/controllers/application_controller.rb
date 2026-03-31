# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_rollbar_context, if: -> { defined?(Rollbar) && respond_to?(:current_user) }

  private

  def user_not_authorized
    redirect_to root_path, alert: t('admin.access_denied')
  end

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
