# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test '#show' do
      user = users(:one)
      sign_in(user)

      get profile_path
      assert_response :success
    end
  end
end
