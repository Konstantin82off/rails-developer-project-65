# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @bulletins = Bulletin.ordered.limit(10)
      @categories = Category.all
    end
  end
end
