# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Auth
    include Pundit::Authorization
  end
end
