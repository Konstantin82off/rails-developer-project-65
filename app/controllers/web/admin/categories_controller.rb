# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :set_category, only: %i[edit update destroy]

      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('admin.categories.create.success')
        else
          render :new, status: :unprocessable_content
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_content
        end
      end

      def destroy
        if @category.bulletins.exists?
          redirect_to admin_categories_path, alert: t('admin.categories.destroy.error')
        else
          @category.destroy
          redirect_to admin_categories_path, notice: t('admin.categories.destroy.success')
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
