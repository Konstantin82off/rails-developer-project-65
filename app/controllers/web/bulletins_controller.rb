# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update to_moderate archive destroy]
    before_action :set_bulletin, only: %i[show edit update to_moderate archive destroy]
    before_action :authorize_bulletin, only: %i[edit update to_moderate archive destroy]

    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def edit; end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: t('.success')
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      if @bulletin.destroy
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def to_moderate
      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def authorize_bulletin
      authorize @bulletin
    end

    def bulletin_params
      params.expect(bulletin: %i[title description category_id image])
    end
  end
end
