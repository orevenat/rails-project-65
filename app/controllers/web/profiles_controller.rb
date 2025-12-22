# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :check_auth!

  def show
    @bulletins = Bulletin.published
                         .where(user: current_user)
  end
end
