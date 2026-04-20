# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  # rubocop:disable Naming/PredicateMethod
  def authenticate_user!
    return true if signed_in?

    redirect_to auth_request_path('github'), alert: t('auth.please_login')
    false
  end
  # rubocop:enable Naming/PredicateMethod
end
