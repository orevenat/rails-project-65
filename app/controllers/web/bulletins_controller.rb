# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :check_auth!, except: %i[index show]

  def index
    @q = Bulletin.ransack(params[:q])

    @bulletins = @q.result.published.page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(permitted_params)

    if @bulletin.save
      redirect_to profile_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity, alert: t(".failure")
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(permitted_params)
      redirect_to profile_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity, alert: t(".failure")
    end
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t(".success")
    else
      redirect_to profile_path, alert: t(".failure")
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: t(".success")
    else
      redirect_to profile_path, alert: t(".failure")
    end
  end

  private

  def permitted_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
