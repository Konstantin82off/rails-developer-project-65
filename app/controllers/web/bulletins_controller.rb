# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create to_moderate archive]
    before_action :set_bulletin, only: %i[show to_moderate archive]

    def index
      @bulletins = Bulletin.published.ordered
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: t('.success')
      else
        render :new, status: :unprocessable_content
      end
    end

    def to_moderate
      if @bulletin.to_moderate
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      if @bulletin.archive
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def authenticate_user!
      return if session[:user_id]

      redirect_to auth_request_path('github'), alert: t('common.please_login')
    end
  end
end
