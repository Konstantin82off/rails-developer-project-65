# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @q = Bulletin.published.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    @categories = Category.all
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def new
    return unless authenticate_user!

    @bulletin = Bulletin.new
  end

  def edit
    return unless authenticate_user!

    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def create
    return unless authenticate_user!

    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    return unless authenticate_user!

    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def to_moderate
    return unless authenticate_user!

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
    return unless authenticate_user!

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
