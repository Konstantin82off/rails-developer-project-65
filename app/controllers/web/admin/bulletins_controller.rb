# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_back_or_to admin_root_url, notice: t('.success')
    else
      redirect_back_or_to admin_root_url, alert: t('.failure')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_back_or_to admin_root_url, notice: t('.success')
    else
      redirect_back_or_to admin_root_url, alert: t('.failure')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_back_or_to admin_root_url, notice: t('.success')
    else
      redirect_back_or_to admin_root_url, alert: t('.failure')
    end
  end
end
