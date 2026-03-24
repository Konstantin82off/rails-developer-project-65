# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]

      def index
        @bulletins = Bulletin.order(created_at: :desc).page(params[:page])
      end

      def publish
        if @bulletin.publish
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.publish.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.publish.failure')
        end
      end

      def reject
        if @bulletin.reject
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.reject.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.reject.failure')
        end
      end

      def archive
        if @bulletin.archive
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.archive.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.archive.failure')
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
