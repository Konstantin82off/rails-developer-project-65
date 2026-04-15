# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.where(state: :under_moderation).ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end
    end
  end
end
