# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        authorize @bulletin

        if @bulletin.may_publish?
          @bulletin.publish!
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.publish.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.publish.failure')
        end
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        authorize @bulletin

        if @bulletin.may_reject?
          @bulletin.reject!
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.reject.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.reject.failure')
        end
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        authorize @bulletin

        if @bulletin.may_archive?
          @bulletin.archive!
          redirect_to admin_bulletins_path, notice: t('admin.bulletins.archive.success')
        else
          redirect_to admin_bulletins_path, alert: t('admin.bulletins.archive.failure')
        end
      end
    end
  end
end
