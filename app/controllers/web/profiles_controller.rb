# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def show
      unless signed_in?
        redirect_to '/auth/github'
        return
      end

      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.ordered.page(params[:page]).per(10)
    end
  end
end
