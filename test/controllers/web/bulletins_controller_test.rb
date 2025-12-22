require "test_helper"

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get root_path
    assert_response :success
  end

  test "#show" do
    user = users(:one)
    sign_in(user)

    bulletin = bulletins(:bulletin_one)
    get bulletin_path(bulletin)
    assert_response :success
  end

  test "#show unathorized" do
    bulletin = bulletins(:bulletin_one)
    get bulletin_path(bulletin)
    assert_response :success
  end

  test "#new" do
    user = users(:one)
    sign_in(user)

    get new_bulletin_path
    assert_response :success
  end

  test "#new unathorized" do
    get new_bulletin_path
    assert_response :redirect
  end

  test "#create" do
    user = users(:one)
    sign_in(user)

    attrs = {
      bulletin: {
        title: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph(sentence_count: 10),
        category_id: Category.first.id
      }
    }

    post bulletins_path, params: attrs

    assert { Bulletin.exists?(title: attrs[:bulletin][:title]) }
    assert { flash[:notice].present? }
    assert_response :redirect
  end

  test "#edit" do
    bulletin = bulletins(:bulletin_one)
    user = users(:one)
    sign_in(user)

    get edit_bulletin_path(bulletin)
    assert_response :success
  end

  test "#update" do
    bulletin = bulletins(:bulletin_one)
    user = users(:one)
    sign_in(user)

    attrs = {
      bulletin: {
        title: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph(sentence_count: 10),
        category_id: Category.first.id
      }
    }

    patch bulletin_path bulletin, params: attrs
    assert_response :redirect
  end

  test "#to_moderate" do
    bulletin = bulletins(:bulletin_draft)
    user = users(:one)
    sign_in(user)

    patch to_moderate_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.under_moderation? }
  end

  test "#archive" do
    bulletin = bulletins(:bulletin_one)
    user = users(:one)
    sign_in(user)

    patch archive_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.archived? }
  end
end
