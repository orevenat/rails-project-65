# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      test '#index' do
        @user = users :admin
        sign_in @user

        get admin_root_path
        assert_response :success
      end

      test '#index unathorize' do
        @user = users :one
        sign_in @user

        get admin_root_path
        assert_response :redirect
      end
    end
  end
end
