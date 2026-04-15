# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      @categories = Category.all
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      authenticate_user!
      return unless signed_in?

      @bulletin = Bulletin.new
    end

    def edit
      authenticate_user!
      return unless signed_in?

      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def create
      authenticate_user!
      return unless signed_in?

      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: t('.success')
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      authenticate_user!
      return unless signed_in?

      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        render :edit, status: :unprocessable_content
      end
    end

    def to_moderate
      authenticate_user!
      return unless signed_in?

      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      authenticate_user!
      return unless signed_in?

      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    private

    def bulletin_params
      params.expect(bulletin: %i[title description category_id image])
    end
  end
end
