# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :set_category, only: %i[edit update destroy]

      def index
        @categories = Category.all
        authorize Category
      end

      def new
        @category = Category.new
        authorize @category
      end

      def edit
        authorize @category
      end

      def create
        @category = Category.new(category_params)
        authorize @category

        if @category.save
          redirect_to admin_categories_path, notice: t('admin.categories.create.success')
        else
          render :new, status: :unprocessable_content
        end
      end

      def update
        authorize @category

        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_content
        end
      end

      def destroy
        authorize @category

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
        params.expect(category: [:name])
      end
    end
  end
end
