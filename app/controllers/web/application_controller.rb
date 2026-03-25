# frozen_string_literal: true

module Web
  class ApplicationController < ::ApplicationController
    helper_method :current_user, :signed_in?

    private

    def current_user
      return @current_user if defined?(@current_user)

      @current_user = User.find_by(id: session[:user_id])
    end

    def signed_in?
      current_user.present?
    end

    def authenticate_user!
      return if signed_in?

      redirect_to '/auth/github'
    end
  end
end
