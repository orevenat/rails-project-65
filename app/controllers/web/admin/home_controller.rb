# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.under_moderation.order(id: :desc).page(params[:page])
      end
    end
  end
end
