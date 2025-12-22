require "test_helper"

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    @user = users :admin
    sign_in @user

    get admin_categories_path
    assert_response :success
  end

  test "#index unathorize" do
    @user = users :one
    sign_in @user

    get admin_categories_path
    assert_response :redirect
  end

  test "#new" do
    @user = users :admin
    sign_in @user

    get new_admin_category_path
    assert_response :success
  end

  test "#create" do
    @user = users :admin
    sign_in @user

    attrs = {
      category: {
        name: 'my new category'
      }
    }

    post admin_categories_path, params: attrs
    assert_response :redirect
    assert { Category.exists?(name: attrs[:category][:name]) }
  end

  test "#edit" do
    @user = users :admin
    sign_in @user

    category = categories(:electronics)

    get edit_admin_category_path(category)
    assert_response :success
  end

  test "#update" do
    @user = users :admin
    sign_in @user

    category = categories(:electronics)
    name = 'my new category'

    attrs = {
      category: {
        name: name
      }
    }

    patch admin_category_url(category), params: attrs

    assert_response :redirect

    category.reload

    assert_equal name, category.name
  end

  test "#destroy" do
    @user = users :admin
    sign_in @user

    category = categories(:cars)

    delete admin_category_path(category)
    assert_response :redirect

    assert_raises(ActiveRecord::RecordNotFound) { category.reload }
    assert { flash[:notice].present? }
  end

  test "#destroy when exists bulletins" do
    @user = users :admin
    sign_in @user

    category = categories(:electronics)

    delete admin_category_path(category)
    assert_response :redirect

    category.reload

    assert { category }
    assert { flash[:alert].present? }
  end
end
