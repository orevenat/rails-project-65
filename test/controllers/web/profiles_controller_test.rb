# frozen_string_literal: true

require "test_helper"

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    user = users(:one)
    sign_in(user)

    get profile_path
    assert_response :success
  end
end
