# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Auth
  include Pundit::Authorization
end
