# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    return unless authenticate_user!

    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.ordered.page(params[:page]).per(10)
  end
end
