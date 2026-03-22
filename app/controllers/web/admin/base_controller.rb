# frozen_string_literal: true

module Web
  module Admin
    class BaseController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin

      private

      def authorize_admin
        return if current_user&.admin?

        redirect_to root_path, alert: t('admin.base.not_authorized')
      end
    end
  end
end
