# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.all
  end

  def publish
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_to admin_root_path, notice: t(".success")
    else
      redirect_to admin_root_path, alert: t(".failure")
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_to admin_root_path, notice: t(".success")
    else
      redirect_to admin_root_path, alert: t(".failure")
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to admin_root_path, notice: t(".success")
    else
      redirect_to admin_root_path, alert: t(".failure")
    end
  end
end
