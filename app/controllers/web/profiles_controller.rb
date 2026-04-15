# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    def show
      authenticate_user!
      return unless signed_in?

      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.ordered.page(params[:page]).per(10)
    end
  end
end
