# frozen_string_literal: true

module Admin
  class BulletinsController < BaseController
    before_action :set_bulletin, only: %i[show edit update destroy publish reject archive]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.ordered.page(params[:page]).per(20)
    end

    def show; end

    def edit; end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to admin_bulletin_path(@bulletin), notice: t('.success')
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @bulletin.destroy
      redirect_to admin_bulletins_path, notice: t('.success')
    end

    def publish
      if @bulletin.publish
        redirect_to admin_bulletins_path, notice: t('.success')
      else
        redirect_to admin_bulletins_path, alert: t('.failure')
      end
    end

    def reject
      if @bulletin.reject
        redirect_to admin_bulletins_path, notice: t('.success')
      else
        redirect_to admin_bulletins_path, alert: t('.failure')
      end
    end

    def archive
      if @bulletin.archive
        redirect_to admin_bulletins_path, notice: t('.success')
      else
        redirect_to admin_bulletins_path, alert: t('.failure')
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
