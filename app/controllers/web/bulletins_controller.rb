# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :check_auth!, except: %i[index show]

  def index
    @bulletins = Bulletin.all
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(permitted_params)

    if @bulletin.save
      redirect_to root_path, notice: I18n.t(".success")
    else
      render :new, status: :unprocessable_content, alert: I18n.t(".failure")
    end
  end

  private

  def permitted_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
