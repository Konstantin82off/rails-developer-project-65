# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.where(state: :under_moderation).ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end
end
