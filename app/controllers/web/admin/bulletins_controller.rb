# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_back_or_to admin_root_url, notice: t('admin.bulletins.publish.success')
    else
      redirect_back_or_to admin_root_url, alert: t('admin.bulletins.publish.failure')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_back_or_to admin_root_url, notice: t('admin.bulletins.reject.success')
    else
      redirect_back_or_to admin_root_url, alert: t('admin.bulletins.reject.failure')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_back_or_to admin_root_url, notice: t('admin.bulletins.archive.success')
    else
      redirect_back_or_to admin_root_url, alert: t('admin.bulletins.archive.failure')
    end
  end
end
