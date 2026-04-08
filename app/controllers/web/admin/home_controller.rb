# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        redirect_to admin_bulletins_path
      end
    end
  end
end
