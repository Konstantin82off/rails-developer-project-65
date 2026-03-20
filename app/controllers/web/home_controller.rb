# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.ordered.page(params[:page]).per(12)
      @categories = Category.all
    end
  end
end
