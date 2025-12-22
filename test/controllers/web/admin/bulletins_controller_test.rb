# frozen_string_literal: true

require "test_helper"

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    @user = users :admin
    sign_in @user

    get admin_bulletins_path
    assert_response :success
  end

  test "#index unathorize" do
    @user = users :one
    sign_in @user

    get admin_bulletins_path
    assert_response :redirect
  end

  test "#publish" do
    bulletin = bulletins(:bulletin_under_moderation)
    user = users(:admin)
    sign_in(user)

    patch publish_admin_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.published? }
  end

  test "#reject" do
    bulletin = bulletins(:bulletin_under_moderation)
    user = users(:admin)
    sign_in(user)

    patch reject_admin_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.rejected? }
  end

  test "#archive" do
    bulletin = bulletins(:bulletin_one)
    user = users(:admin)
    sign_in(user)

    patch archive_admin_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.archived? }
  end
end
