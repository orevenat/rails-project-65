# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :check_auth!

  def show
    @q = Bulletin.ransack(params[:q])

    @bulletins = @q.result
                   .where(user: current_user)
                   .order(updated_at: :desc)
                   .page(params[:page])
  end
end
