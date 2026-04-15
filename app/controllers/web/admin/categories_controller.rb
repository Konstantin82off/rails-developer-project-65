# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
    authorize Category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    @category = Category.find(params[:id])
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
    @category = Category.find(params[:id])
    authorize @category

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('admin.categories.update.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category

    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: t('admin.categories.destroy.error')
    else
      @category.destroy
      redirect_to admin_categories_path, notice: t('admin.categories.destroy.success')
    end
  end

  private

  def category_params
    params.expect(category: [:name])
  end
end
