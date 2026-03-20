# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.ordered.page(params[:page]).per(10)
    end
  end
end
