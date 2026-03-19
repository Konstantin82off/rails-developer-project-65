# frozen_string_literal: true

module Admin
  class BulletinsController < BaseController
    def index
      @bulletins = Bulletin.ordered
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
    end

    def update
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.update(bulletin_params)
        redirect_to admin_bulletin_path(@bulletin), notice: t('.success')
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])
      @bulletin.destroy

      redirect_to admin_bulletins_path, notice: t('.success')
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
