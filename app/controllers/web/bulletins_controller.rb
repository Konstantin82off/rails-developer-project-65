# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create]

    def index
      @bulletins = Bulletin.ordered
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

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

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def authenticate_user!
      return if session[:user_id]

      redirect_to auth_request_path('github'), alert: t('common.please_login')
    end
  end
end
